# Recursive append and backward queries

Part 2 append example; also extends `Unification append(X,Y,Z)_rev.docx`.

Load from the repository root in SWI-Prolog:

```prolog
?- ['CIS774_Prolog_Part2_Examples/append-lists.pl'].
```

Run these queries:

```prolog
?- append_demo([], [1,2,3], Z).
?- append_demo([1,2], [3,4], Z).
?- append_demo(X, Y, [1,2]).
```

The second query produces `Z = [1,2,3,4]`. The third enumerates splits: `([], [1,2])`, `([1], [2])`, `([1,2], [])`; press `;` for more.

## Step-by-step recursion

The following figure traces `append_demo([1,2], [3,4], Z)` from the initial call through the base case and back to the final binding.

![Recursion trace for append_demo([1,2], [3,4], Z), descending to the empty-list base case and returning with Z = [1,2,3,4].](append-recursion-trace.svg)

*Figure 1. Recursive list concatenation: descending calls reach the base case, then variable bindings propagate upward to construct the result.*

### Accessible text description of Figure 1

**Descending recursive calls:**

1. **Call 1:** `append_demo([1,2], [3,4], Z)` matches the recursive rule. Unifying `[A|B]` with `[1,2]` gives `A = 1` and `B = [2]`. The result has the form `Z = [1|W1]`, and the next call is `append_demo([2], [3,4], W1)`.
2. **Call 2:** `append_demo([2], [3,4], W1)` gives `A = 2`, `B = []`, and `W1 = [2|W2]`. The next call is `append_demo([], [3,4], W2)`.
3. **Call 3 (base case):** `append_demo([], [3,4], W2)` matches `append_demo([], Y, Y)`, binding `W2 = [3,4]`. No further recursive call is needed.

**Returning from recursion:**

1. **Return to Call 2:** Substitute `W2 = [3,4]` into `W1 = [2|W2]`, giving `W1 = [2,3,4]`.
2. **Return to Call 1:** Substitute `W1 = [2,3,4]` into `Z = [1|W1]`, giving `Z = [1,2,3,4]`.

The return steps show **propagation of variable bindings after successful recursive calls**, not backtracking to try an alternative clause.

**Accessibility note:** The description above provides the sequence of recursive calls, the base case, and the returning bindings in text, so the explanation does not depend on viewing the figure.

### Why does the base case give `W2 = [3,4]`?

The base case is:

```prolog
append_demo([], Y, Y).
```

The last recursive call is:

```prolog
append_demo([], [3,4], W2).
```

Unify the corresponding arguments:

| Argument | Base-case rule | Recursive call | Result |
| --- | --- | --- | --- |
| First | `[]` | `[]` | Matches |
| Second | `Y` | `[3,4]` | `Y = [3,4]` |
| Third | `Y` | `W2` | `W2 = Y = [3,4]` |

The **same variable `Y` appears in both the second and third arguments** of the base-case rule. Therefore, when `Y` becomes bound to `[3,4]`, the third argument `W2` must be `[3,4]` too.

Now the bindings propagate back through the recursive calls:

```text
W2 = [3,4]
W1 = [2|W2] = [2,3,4]
Z  = [1|W1] = [1,2,3,4]
```

This is **returning from recursion and propagating bindings**, not backtracking to try an alternative clause.

Note: `W1` and `W2` are separate variables for separate recursive calls. This makes the return substitutions clearer than reusing `W` in each frame.
