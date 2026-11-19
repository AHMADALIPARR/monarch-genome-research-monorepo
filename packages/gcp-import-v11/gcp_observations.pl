:- module(gcp_observations, [observation/5, source/2, expected_trials/2, well_formed/1]).
source(gcp1_1999_01_01, 'https://www.global-mind.org/data/eggsummary/1999/summary-1999-01-01.html').
expected_trials(900, 180000).
well_formed(N) :- observation(N, _, Ones, Trials, _), integer(Ones), integer(Trials), Trials > 0, Ones >= 0, Ones =< Trials.
observation(0, '1999-01-01T00:00:00Z', 811135, 1620000, 1.78).
observation(1, '1999-01-01T00:15:00Z', 810454, 1619600, 1.03).
observation(2, '1999-01-01T00:30:00Z', 810714, 1620000, 1.12).
observation(3, '1999-01-01T00:45:00Z', 810747, 1619800, 1.33).
observation(4, '1999-01-01T01:00:00Z', 809865, 1620000, 0.21).
observation(5, '1999-01-01T01:15:00Z', 810359, 1620000, 0.56).
observation(6, '1999-01-01T01:30:00Z', 810721, 1620000, 1.13).
observation(7, '1999-01-01T01:45:00Z', 810165, 1620000, 0.26).
observation(8, '1999-01-01T02:00:00Z', 809230, 1620000, 1.21).
observation(9, '1999-01-01T02:15:00Z', 810264, 1620000, 0.41).
observation(10, '1999-01-01T02:30:00Z', 811624, 1620000, 2.55).
