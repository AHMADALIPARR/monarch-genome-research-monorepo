:- module(monarch_claims, [load_corpus/1, story/16, claim/7, source_cluster/2,
                            shared_source/2, possible_corrob/2, claim_needs_review/2,
                            export_claims/1, export_source_clusters/1, export_shared_sources/1,
                            run/0]).
:- use_module(library(csv)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(aggregate)).
:- dynamic story/16.
:- dynamic claim/7.

/* Input: original 15-column CSV. This program never promotes the contents of
   claimant-authored text or secondhand summaries into independently verified facts.
   Output claims are source-attributed assertions, not scientific conclusions. */

load_corpus(Path) :-
    retractall(story(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
    retractall(claim(_,_,_,_,_,_,_)),
    csv_read_file(Path, Rows, [functor(row), encoding(utf8)]),
    Rows = [_Header|Data],
    maplist(add_story, Data),
    findall(Id, story(Id,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_), Ids),
    maplist(add_claims_for_story, Ids).

add_story(row(Id, Title, Program, Period, Place, People, Kind, Summary,
              Category, Evidence, Methods, Outcome, URL, SourceType, Notes)) :-
    assertz(story(Id,Title,Program,Period,Place,People,Kind,Summary,
                  Category,Evidence,Methods,Outcome,URL,SourceType,Notes,URL)).

add_claims_for_story(Id) :-
    story(Id,_,_,_,_,_,_,Summary,_,Evidence,Methods,Outcome,URL,_,Notes,_),
    add_claim(Id, summary, Summary, Evidence, URL),
    ( Methods == 'Not applicable' -> true
    ; atomic_list_concat(Parts, ';', Methods),
      forall(member(P, Parts), (normalize_space(atom(M), P), add_claim(Id, reported_method, M, Evidence, URL)))
    ),
    add_claim(Id, outcome_or_limit, Outcome, Evidence, URL),
    add_claim(Id, research_caveat, Notes, Evidence, URL).

add_claim(Id, Kind, Text, Evidence, URL) :-
    aggregate_all(count, claim(_,_,_,_,_,_,_), N),
    Seq is N+1,
    format(atom(ClaimId), 'C~|~`0t~d~5+', [Seq]),
    assertz(claim(ClaimId, Id, Kind, Text, Evidence, URL, source_attributed)).

% An identical URL gives one source cluster, regardless of how many stories cite it.
source_cluster(URL, Stories) :-
    setof(Id, story_by_source(URL, Id), Stories).

story_by_source(URL, Id) :-
    story(Id,_,_,_,_,_,_,_,_,_,_,_,URL,_,_,_).

shared_source(A, B) :-
    story(A,_,_,_,_,_,_,_,_,_,_,_,URL,_,_,_),
    story(B,_,_,_,_,_,_,_,_,_,_,_,URL,_,_,_),
    A @< B.

% Two different URLs are only candidates for independent corroboration, never proof.
possible_corrob(A, B) :-
    story(A,_,P,_,_,_,_,_,_,_,_,_,URL1,_,_,_),
    story(B,_,P,_,_,_,_,_,_,_,_,_,URL2,_,_,_),
    A @< B, URL1 \== URL2.

claim_needs_review(Id, unverified_monarch_allegation) :-
    story(Id,_,Program,_,_,_,_,_,_,_,_,_,_,_,_,_),
    sub_atom(Program, _, _, _, 'Alleged Project MONARCH').
claim_needs_review(Id, individual_source_verification) :-
    story(Id,_,_,_,_,_,_,_,_,Evidence,_,_,_,_,_,_),
    ( sub_atom(Evidence, _, _, _, 'disputed')
    ; sub_atom(Evidence, _, _, _, 'unverified')
    ; sub_atom(Evidence, _, _, _, 'contested')
    ; sub_atom(Evidence, _, _, _, 'First-person')
    ).

export_claims(Path) :-
    setup_call_cleanup(open(Path,write,Out,[encoding(utf8)]),
      (csv_write_stream(Out,[row(claim_id,story_id,claim_type,claim_text,evidence_status,source_url,epistemic_status)],[]),
       forall(claim(C,S,K,T,E,U,F),csv_write_stream(Out,[row(C,S,K,T,E,U,F)],[]))),close(Out)).

export_source_clusters(Path) :-
    setup_call_cleanup(open(Path,write,Out,[encoding(utf8)]),
      (csv_write_stream(Out,[row(source_url,story_count,story_ids)],[]),
       forall(source_cluster(U,Ids),
         (length(Ids,N),atomic_list_concat(Ids,';',Joined),csv_write_stream(Out,[row(U,N,Joined)],[])))),close(Out)).

export_shared_sources(Path) :-
    setup_call_cleanup(open(Path,write,Out,[encoding(utf8)]),
      (csv_write_stream(Out,[row(story_a,story_b,relationship,independent_corroboration)],[]),
       forall(shared_source(A,B),csv_write_stream(Out,[row(A,B,same_source,no)],[]))),close(Out)).

run :-
    load_corpus('monarch_mkultra_stories_seed.csv'),
    export_claims('monarch_claims.csv'),
    export_source_clusters('monarch_source_clusters.csv'),
    export_shared_sources('monarch_shared_sources.csv').
