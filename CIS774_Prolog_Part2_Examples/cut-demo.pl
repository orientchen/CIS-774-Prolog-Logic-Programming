% Demonstrate pruning.
choice(amy).
choice(bob).
first_choice(X) :- choice(X), !.
all_choices(X) :- choice(X).

% Finite integer generation with a cut at the upper bound.
range_cut(I, J, I) :- I =< J.
range_cut(I, J, X) :- I < J, Next is I+1, range_cut(Next, J, X).
