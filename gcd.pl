% gcd.pl
% Chapter 4 - Logic Programming
% Example 10: Euclidean algorithm (slides 35-36)
%
% gcd(U, V, W) means W is the greatest common divisor of U and V.
% Intended for nonnegative integers U, V (not both zero).

% Base case: gcd(U, 0) = U.
gcd(U, 0, U) :- U > 0.

% Recursive case: gcd(U, V) = gcd(V, U mod V), for V > 0.
gcd(U, V, W) :-
    V > 0,
    R is U mod V,
    gcd(V, R, W).

% Sample queries (enter at the Prolog prompt):
% ?- gcd(15, 10, X).    % X = 5
% ?- gcd(24, 18, X).    % X = 6
% ?- gcd(21, 14, 7).   % true
% ?- gcd(21, 14, 5).   % false
%
% Resolution for gcd(15, 10, X):
%   gcd(15, 10, X) -> gcd(10, 5, X)
%   gcd(10, 5, X)  -> gcd(5, 0, X)
%   gcd(5, 0, X)   -> X = 5
%
% Note: 'is' evaluates arithmetic. 'mod' computes the remainder.
