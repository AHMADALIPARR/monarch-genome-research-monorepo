:- module(monarch_recovery, [load_recovery/1, recovery/10, narrative_recovery/2, clinical_recovery/2, recovery_claim_review/2, shared_recovery_source/2, story_recovery/2, count_recovery/1]).
:- use_module(library(csv)).
:- dynamic recovery/10.

% The epistemic class is a property of the citation/claim type, not a truth verdict.
load_recovery(Path) :-
    retractall(recovery(_,_,_,_,_,_,_,_,_,_)),
    csv_read_file(Path, [_|Data], [functor(row), encoding(utf8)]),
    maplist(import_recovery, Data).

import_recovery(row(Id,Story,Framework,Stage,Claim,Practice,Outcome,Class,URL,Note)) :-
    assertz(recovery(Id,Story,Framework,Stage,Claim,Practice,Outcome,Class,URL,Note)).

narrative_recovery(Id, Claim) :-
    recovery(Id,_,monarch_narrative,_,Claim,_,_,_,_,_).

clinical_recovery(Id, Claim) :-
    recovery(Id,_,Framework,_,Claim,_,_,_,_,_),
    memberchk(Framework,[clinical_guidance,clinical_evidence,memory_science]).

story_recovery(Story, Id) :-
    recovery(Id,Story,_,_,_,_,_,_,_,_), Story \== ''.

recovery_claim_review(Id, unverified_program_connection) :-
    recovery(Id,_,monarch_narrative,_,_,_,_,_,_,_).
recovery_claim_review(Id, suggestibility_caution) :-
    recovery(Id,_,_,_,Claim,Practice,_,_,_,_),
    (sub_atom(Practice,_,_,_,'hypnosis'); sub_atom(Claim,_,_,_,'memories')).

% Same URL is source reuse, never independent corroboration.
shared_recovery_source(A,B) :-
    recovery(A,_,_,_,_,_,_,_,URL,_),
    recovery(B,_,_,_,_,_,_,_,URL,_), A @< B.

count_recovery(N) :- aggregate_all(count,recovery(_,_,_,_,_,_,_,_,_,_),N).
