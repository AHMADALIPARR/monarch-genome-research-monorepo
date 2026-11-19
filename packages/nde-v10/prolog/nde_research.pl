% Read-only study summaries, not patient records.
:- module(nde_research, [study/5, reported_fraction/2, sourced_study/1, evidence_invariant/1, comparable_dimensions/3]).
study(nde001, 2001, 344, 62, 'https://pubmed.ncbi.nlm.nih.gov/11755611/').
study(nde002, 2014, unknown, unknown, 'https://www.sciencedirect.com/science/article/pii/S0300957214007394').
study(nde003, 2023, 567, unknown, 'https://pubmed.ncbi.nlm.nih.gov/37423492/').
study(nde004, 2023, 4, unknown, 'https://doi.org/10.1073/pnas.2216268120').
reported_fraction(Study, Fraction) :- study(Study, _, N, R, _), integer(N), integer(R), N > 0, Fraction is R / N.
sourced_study(Study) :- study(Study, _, _, _, URL), atom(URL), sub_atom(URL, 0, 4, _, 'http').
evidence_invariant(Study) :- sourced_study(Study).
% Shared measurement domains permit comparison; they do not imply common causes.
comparable_dimensions(nde, post_recovery, [memory, distress, functioning, agency]).
comparable_dimensions(nde, mkultra, [memory, distress, functioning]).
