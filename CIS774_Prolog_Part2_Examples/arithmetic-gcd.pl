% Arithmetic evaluation and Euclidean algorithm.
gcd_demo(U, 0, U).
gcd_demo(U, V, G) :- V =\= 0, R is U mod V, gcd_demo(V, R, G).
