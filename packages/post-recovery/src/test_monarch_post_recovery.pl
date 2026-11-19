:- begin_tests(post_recovery).
:- use_module(monarch_post_recovery).

test(valid_example) :- example_trace(T), assess_trace(T,report(valid,_)).
test(cognition_at_one) :- example_trace(T), cognition_after(T,1,profile(3,3,2,2,4)).
test(noncoercion_valid) :- example_trace([S|_]), recovery_invariant(S,consent_and_noncoercion).
test(fluctuation_allowed) :- example_trace([_,S1,S2]), valid_transition(S1,S2).
test(recalled_memory_not_verified) :- example_trace([S|_]), recovery_claim_is_not_proof(S,requires_independent_evidence).
test(no_consent_flagged) :-
    S=state(0,no,false,false,2,3,3,1,3,none),state_flag(S,coercion_or_no_consent).
test(pressure_flagged) :-
    S=state(0,yes,false,true,2,3,3,1,3,none),state_flag(S,pressured_recall).
test(invalid_score_rejected, [fail]) :-
    valid_state(state(0,yes,false,false,5,3,3,1,3,none)).
test(backwards_transition_rejected, [fail]) :-
    valid_transition(state(2,yes,false,false,2,3,2,2,2,none),
                     state(1,yes,false,false,3,3,2,2,2,none)).
test(high_confidence_not_proof) :-
    recovery_claim_is_not_proof(state(0,yes,false,false,4,4,0,4,4,none),requires_independent_evidence).
:- end_tests(post_recovery).
