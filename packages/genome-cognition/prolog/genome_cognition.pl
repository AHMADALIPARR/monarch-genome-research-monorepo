:- module(genome_cognition,
          [cognitive_state/5,
           valid_observation/1,
           valid_trace/1,
           apparent_change/3,
           evidence_support/2,
           causal_conclusion_allowed/1]).

% Pure mathematical observations, not experimental measurements.
% state(Time, Agency, Orientation, Distress, Functioning), values 0..4.
cognitive_state(T,A,O,D,F) :-
    integer(T), T >= 0,
    maplist(score, [A,O,D,F]).
score(X) :- integer(X), between(0,4,X).

valid_observation(obs(T,A,O,D,F,Source)) :-
    cognitive_state(T,A,O,D,F),
    nonvar(Source), Source \== unknown.

valid_trace([]).
valid_trace([X|Xs]) :- valid_observation(X), valid_trace(Xs).

% Pure difference in self-reported score, never a causal finding.
apparent_change(obs(_,A0,_,_,_,_),obs(_,A1,_,_,_,_),Delta) :-
    integer(A0),integer(A1),Delta is A1-A0.

% Evidentiary tiers. The photo cannot validate any cognitive outcome.
evidence_support(image_schematic, molecular_components_only).
evidence_support(reported_account, testimony_only).
evidence_support(synthetic_trace, mathematical_behavior_only).
evidence_support(measured_longitudinal_study, association_candidate).

% No causal status is inferred from these evidence tiers alone.
causal_conclusion_allowed(_) :- fail.
