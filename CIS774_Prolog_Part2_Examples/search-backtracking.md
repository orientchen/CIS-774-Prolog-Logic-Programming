# Depth-first search, backtracking, and clause order

Based on *Prolog's Search Mechanism* PDF and Part 2 slides. Load: `[search-backtracking].`

```prolog
ancestor_search(H, bob).
```

Press `;` after the first answer. The two answers are `H=amy`, then `H=bob`.

## Resolution trace

1. Goal `ancestor_search(H,bob)` selects the first rule, producing `parent_search(H,Z), ancestor_search(Z,bob)`.
2. The parent fact unifies `H=amy`, `Z=bob`.
3. Recursive goal `ancestor_search(bob,bob)` first tries the recursive rule; `parent_search(bob,_)` fails.
4. Backtrack to the base rule `ancestor_search(X,X)`; it succeeds. First result `H=amy`.
5. On `;`, Prolog backtracks to the original goal and tries its base rule: `H=bob`.

**Warning:** Changing clause order can create nontermination. Prolog searches clauses top to bottom and goals left to right; do not run an unguarded left-recursive ancestor rule in class.
