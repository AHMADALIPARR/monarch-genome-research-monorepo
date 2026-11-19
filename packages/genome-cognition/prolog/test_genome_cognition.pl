:- begin_tests(genome_cognition).
:- use_module(genome_cognition).

test(bounds) :- cognitive_state(0, 2,3,1,4).
test(reject_negative, [fail]) :- cognitive_state(0,-1,3,1,4).
test(reject_unattributed, [fail]) :- valid_observation(obs(0,2,3,1,4,unknown)).
test(difference) :- apparent_change(obs(0,2,3,1,4,synthetic),obs(1,3,3,1,4,synthetic),1).
test(no_causality, [fail]) :- causal_conclusion_allowed(image_schematic).
:- end_tests(genome_cognition).
