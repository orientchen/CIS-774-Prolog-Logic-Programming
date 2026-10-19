# List unification

Part 2: list notation and unification.

Load: `[list-unification].`

Queries (enter without `?-` at the SWI-Prolog prompt):

```prolog
example_head_tail([1,2,3], H, T).
example_two_heads([1,2,3], X, Y, Z).
[H|T] = [1,2,3].
[X,Y|Z] = [1,2,3].
```

Expected: `H=1, T=[2,3]`; and `X=1, Y=2, Z=[3]`.

**Resolution/unification:** `[H|T]` matches the first element with `H` and the remaining list with `T`. List patterns must match the list structure.
