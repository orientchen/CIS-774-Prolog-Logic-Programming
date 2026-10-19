% Clause order and depth-first search; adapted from the uploaded search mechanism.
ancestor_search(X,Y) :- parent_search(X,Z), ancestor_search(Z,Y).
ancestor_search(X,X).
parent_search(amy,bob).
