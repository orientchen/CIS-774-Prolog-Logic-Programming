# Recursive reverse using append

Part 2 reverse procedure. Load: `[reverse-lists].`

```prolog
reverse_demo([1,2,3], R).
reverse_demo([], R).
```

Trace for the first query:

1. Reverse `[2,3]`, then append `[1]`.
2. Reverse `[3]`, then append `[2]`.
3. Reverse `[]` to `[]`.
4. Append `[]` and `[3]` -> `[3]`.
5. Append `[3]` and `[2]` -> `[3,2]`.
6. Append `[3,2]` and `[1]` -> `R=[3,2,1]`.

Compare the recursion's descent with the substitutions on return.
