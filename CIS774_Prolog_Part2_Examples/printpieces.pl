% Example supplied with Part 2 lecture.
printpieces(L) :-
    append(X, Y, L),
    write(X), write(' '), write(Y), nl,
    fail.
printpieces(_).
