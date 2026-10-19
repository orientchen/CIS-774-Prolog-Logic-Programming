% Reverse using the recursive append definition.
reverse_demo([], []).
reverse_demo([H|T], R) :- reverse_demo(T, RT), append_demo(RT, [H], R).
append_demo([], Y, Y).
append_demo([A|B], Y, [A|W]) :- append_demo(B, Y, W).
