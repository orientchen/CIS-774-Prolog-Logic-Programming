# Forced backtracking with fail

This is the supplied `printpieces.pl` example, kept unchanged. Load: `[printpieces].`

```prolog
printpieces([1,2,3]).
```

Output (each line is one split):

```text
[] [1,2,3]
[1] [2,3]
[1,2] [3]
[1,2,3] []
```

`append(X,Y,L)` generates a split. `write` prints it. `fail` forces backtracking to the next split. After all splits are exhausted, the second clause `printpieces(_)` succeeds, so the overall query succeeds.

Compare with `append(X,Y,[1,2,3]).` and press `;` to see each split without printing.
