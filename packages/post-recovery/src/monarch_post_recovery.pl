:- module(monarch_post_recovery,
          [valid_state/1, valid_transition/2, recovery_invariant/2,
           cognition_after/3, state_flag/2, assess_trace/2,
           recovery_claim_is_not_proof/2, example_trace/1]).

/*
  A conceptual, non-diagnostic state model for longitudinal observations after
  a person's *reported* recovery/deprogramming experience. No clinical outcome,
  disputed historical allegation, or recovered-memory content is presumed true.

  state(Time, Consent, Coercion, RecallPressure, Agency, Orientation,
        Distress, Function, MemoryConfidence, IndependentCorroboration)

  Consent: yes/no; Coercion, RecallPressure: true/false
  Agency, Orientation, Distress, Function, MemoryConfidence: 0..4 self-report
  IndependentCorroboration: none/pending/verified/disconfirmed

  Ordinal values describe user-specified observations, not validated instruments.
*/

score(X) :- integer(X), between(0,4,X).
corroboration(none).
corroboration(pending).
corroboration(verified).
corroboration(disconfirmed).

valid_state(state(T,C,Coercion,Pressure,A,O,D,F,MC,Cor)) :-
    number(T),
    memberchk(C,[yes,no]),
    memberchk(Coercion,[true,false]),
    memberchk(Pressure,[true,false]),
    score(A), score(O), score(D), score(F), score(MC),
    corroboration(Cor).

% The invariant is a process-level ethical condition, NOT a guarantee
% of how an individual's cognition must behave.
recovery_invariant(state(_,yes,false,false,_,_,_,_,_,_), consent_and_noncoercion).
recovery_invariant(S, memory_not_self_validating) :- valid_state(S).

% Recovery may fluctuate; changes in cognition are tracked, not forbidden.
valid_transition(Before,After) :-
    valid_state(Before), valid_state(After),
    Before = state(T1,_,_,_,_,_,_,_,_,_),
    After  = state(T2,_,_,_,_,_,_,_,_,_),
    T2 > T1.

% Query the post-recovery cognition at a time in an observational trace.
cognition_after(Trace,Time,profile(Agency,Orientation,Distress,Function,MemoryConfidence)) :-
    member(state(Time,_,_,_,Agency,Orientation,Distress,Function,MemoryConfidence,_),Trace).

state_flag(S, coercion_or_no_consent) :-
    valid_state(S), S=state(_,C,Coercion,_,_,_,_,_,_,_),
    (C == no ; Coercion == true).
state_flag(S, pressured_recall) :-
    valid_state(S), S=state(_,_,_,true,_,_,_,_,_,_).
state_flag(S, distress_reported_high) :-
    valid_state(S), S=state(_,_,_,_,_,_,D,_,_,_), D >= 3.
state_flag(S, orientation_reported_low) :-
    valid_state(S), S=state(_,_,_,_,_,O,_,_,_,_), O =< 1.
state_flag(S, reduced_agency_reported) :-
    valid_state(S), S=state(_,_,_,_,A,_,_,_,_,_), A =< 1.

assess_trace(Trace, report(Integrity,Flags)) :-
    Trace = [_|_],
    ( forall(member(S,Trace),valid_state(S)), ordered(Trace) -> Integrity = valid
    ; Integrity = invalid ),
    findall(at(T,Flag),
       (member(S,Trace),S=state(T,_,_,_,_,_,_,_,_,_),state_flag(S,Flag)),Flags).

ordered([_]).
ordered([A,B|Rest]) :- valid_transition(A,B), ordered([B|Rest]).

% Recalled content, however confident, is not automatically evidence of
% the claimed historical event. Only independent evidence can support it.
recovery_claim_is_not_proof(S, requires_independent_evidence) :-
    valid_state(S),
    S=state(_,_,_,_,_,_,_,_,_,Cor),
    Cor \== verified.
recovery_claim_is_not_proof(S, independent_evidence_recorded_not_causation) :-
    valid_state(S),
    S=state(_,_,_,_,_,_,_,_,_,verified).

example_trace([
    state(0,yes,false,false,2,3,3,1,3,none),
    state(1,yes,false,false,3,3,2,2,4,pending),
    state(2,yes,false,false,2,4,3,2,4,pending)
]).
