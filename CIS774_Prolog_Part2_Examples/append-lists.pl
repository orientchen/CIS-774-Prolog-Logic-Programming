% Recursive list append; named append_demo to distinguish built-in append/3.
append_demo([], Y, Y).
append_demo([A|B], Y, [A|W]) :- append_demo(B, Y, W).
