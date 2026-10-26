
% Demonstrate pruning.
choice(amy).
choice(bob).

first_choice(X) :- choice(X), !.
all_choices(X) :- choice(X).

% Finite integer generation.
range_cut(I, J, I) :- I =< J.
range_cut(I, J, X) :-
    I < J,
    Next is I + 1,
    range_cut(Next, J, X).

% Slide 29: Use cut to stop an unbounded integer generator.
num(0).
num(X) :-
    num(Y),
    X is Y + 1.

writenum(I, J) :-
    num(X),
    I =< X,
    X =< J,
    write(X), nl,
    X = J, !,
    fail.

