% horse.pl
% Chapter 4 - Logic Programming
% Example 9: Resolution and unification (slides 33-34)
%
% Rules: an animal with two arms has two legs;
%        an animal with zero arms has four legs.
% These rules are simplified teaching examples, not biological laws.

legs(X, 2) :- mammal(X), arms(X, 2).
legs(X, 4) :- mammal(X), arms(X, 0).

% Facts
mammal(horse).
arms(horse, 0).

% Sample queries (enter at the Prolog prompt):
% ?- legs(horse, 4).     % true
% ?- legs(horse, 2).     % false
% ?- legs(horse, N).     % N = 4
% ?- mammal(horse).      % true
%
% Unification for legs(horse, 4):
%   legs(X, 4) matches legs(horse, 4) with X = horse.
%   Subgoals: mammal(horse), arms(horse, 0).
%   Both are facts, so the query succeeds.
