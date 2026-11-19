:- module(monarch_torus_analysis,
 [historical_case/5, case_effect/3, reported_association/3,
  source_supported/1, correlation_ready/1, recovery_is_not_proof/1,
  torus_angle/3, torus_distance/5, entropy_bits/2,
  mixture_entropy/4, entropy_bound/2, example_checks/0]).
/*
 Evidence-aware analysis. historical_case/5 facts generated from seed CSV.
 reported_association/3 is a text-level association, NOT a causal or numeric correlation.
 angles are in radians; torus distances use the flat 2-torus metric.
 No predicate asserts MONARCH was operational or that mental states are quantum states.
*/
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(readutil)).
:- use_module(library(error)).

source_supported(ID) :- historical_case(ID,_,_,_,documented).
correlation_ready(ID) :- historical_case(ID,_,_,_,documented),
    % The original record set provides no paired, calibrated clinical scores.
    fail.
reported_association(ID,Effect,Level) :- case_effect(ID,Effect,Level).
recovery_is_not_proof(reported_recovery).

% Continuous coordinates in [0,1] -> angles on S1 x S1.
torus_angle(U,V,angle(A,B)) :-
  must_be(number,U), must_be(number,V),
  U >= 0, U =< 1, V >= 0, V =< 1,
  P is 2*pi, A is P*U, B is P*V.

circular_delta(A,B,D) :-
  P is 2*pi, Raw is abs(A-B),
  X is Raw - P*floor(Raw/P),
  D is min(X,P-X).
torus_distance(A1,B1,A2,B2,D) :-
  circular_delta(A1,A2,DA), circular_delta(B1,B2,DB),
  D is sqrt(DA*DA+DB*DB).

valid_weights(W) :- W = [_|_],
  maplist(nonnegative_number,W), sum_list(W,Total), Total > 0.
nonnegative_number(X) :- number(X), X >= 0.
entropy_bits(Weights,H) :-
  valid_weights(Weights), sum_list(Weights,Sum),
  findall(T,(member(W,Weights), W > 0, P is W/Sum,
             T is -P*log(P)/log(2)),Terms),
  sum_list(Terms,H).

% Convex mixture: (1-Lambda)*P + Lambda*Q. This is NOT quantum superposition.
mixture_entropy(P,Q,Lambda,H) :-
  valid_weights(P), valid_weights(Q), same_length(P,Q),
  number(Lambda), Lambda >= 0, Lambda =< 1,
  sum_list(P,SP),sum_list(Q,SQ),
  maplist(mix_value(SP,SQ,Lambda),P,Q,Mix), entropy_bits(Mix,H).
mix_value(SP,SQ,L,A,B,M) :- M is (1-L)*A/SP + L*B/SQ.

% Shannon theorem: 0 <= H <= log2(n) for discrete finite n.
entropy_bound(P,within_bound) :-
  valid_weights(P), length(P,N), entropy_bits(P,H),
  Max is log(N)/log(2), H >= -1.0e-10, H =< Max+1.0e-10.

example_checks :-
  entropy_bits([1,1,1,1],H), abs(H-2) < 1.0e-10,
  entropy_bits([1,0,0,0],Z), abs(Z) < 1.0e-10,
  mixture_entropy([1,0],[0,1],0.5,M),abs(M-1) < 1.0e-10,
  torus_distance(0,0,2*pi,0,D), D < 1.0e-9,
  entropy_bound([1,1,0,0],within_bound).
