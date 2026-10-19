# Recursive List Reversal Using `append` (Part 2)

This example accompanies **Chapter 4: Logic Programming, Part 2**, particularly the slide on the recursive `reverse` procedure. It demonstrates **list decomposition**, **recursion**, **the base case**, and **unification of intermediate results** as recursive calls return.

## 1. Prolog program

Open [`reverse-lists.pl`](reverse-lists.pl) to see the executable version. The lecture calls the predicate `reverse/2`; this example names it `reverse_demo/2` to distinguish it from SWI-Prolog's built-in `reverse/2`.

```prolog
% Base case: reversing an empty list gives an empty list.
reverse_demo([], []).

% Recursive case: reverse the tail, then append the head.
reverse_demo([H|T], R) :-
    reverse_demo(T, RT),
    append_demo(RT, [H], R).

% Append base case.
append_demo([], Y, Y).

% Append recursive case.
append_demo([A|B], Y, [A|W]) :-
    append_demo(B, Y, W).
```

Here, `H` is the head of the list, `T` is its tail, `RT` is the reversed tail (the lecture slide calls this temporary variable `L1`), and `R` is the final reversed list. The name `RT` is local to each recursive invocation: each call has its own fresh variables.

## 2. Run in GitHub Codespaces

From the **repository root**, start SWI-Prolog:

```bash
swipl
```

At the `?-` Prolog prompt, load the program using its folder path:

```prolog
?- ['CIS774_Prolog_Part2_Examples/reverse-lists.pl'].
```

Then try:

```prolog
?- reverse_demo([1,2,3], R).
R = [3,2,1].

?- reverse_demo([], R).
R = [].
```

If you first change your terminal directory to `CIS774_Prolog_Part2_Examples`, you can instead load the file with `?- ['reverse-lists.pl'].`

## 3. Recursion trace: `reverse_demo([1,2,3], R)`

The figure shows the recursive calls **descending** until the empty-list base case, followed by the `append_demo` operations **returning upward**.

![Prolog reverse trace: four calls reach the empty-list base case; append operations return the reversed list [3,2,1].](reverse-recursion-trace.png)

*Figure 1. Recursive list reversal: calls descend to the base case, then intermediate results propagate upward.*

### Accessible text description of Figure 1

**Descending recursive calls:**

1. **Call 1:** `reverse_demo([1,2,3], R)`. Match `[H|T]` with `[1,2,3]`: `H = 1`, `T = [2,3]`. Call `reverse_demo([2,3], L1)` before appending `[1]`.
2. **Call 2:** `reverse_demo([2,3], L1)`. Here `H = 2`, `T = [3]`. Call `reverse_demo([3], L2)` before appending `[2]`.
3. **Call 3:** `reverse_demo([3], L2)`. Here `H = 3`, `T = []`. Call `reverse_demo([], L3)` before appending `[3]`.
4. **Call 4 (base case):** `reverse_demo([], L3)` unifies with the rule `reverse_demo([], [])`. Therefore, `L3 = []`. No additional recursive call is needed.

**Returning from recursion:**

1. **Return to Call 3:** `append_demo(L3, [3], L2)` becomes `append_demo([], [3], L2)`. The append base case `append_demo([], Y, Y)` binds `L2 = [3]`.
2. **Return to Call 2:** `append_demo(L2, [2], L1)` becomes `append_demo([3], [2], L1)`. Therefore, `L1 = [3,2]`.
3. **Return to Call 1:** `append_demo(L1, [1], R)` becomes `append_demo([3,2], [1], R)`. Therefore, `R = [3,2,1]`.

The return steps above are **propagation of bindings after successful recursive calls**, not backtracking to search for alternative solutions.

## 4. Why does the base case return `[]`?

The base-case clause is:

```prolog
reverse_demo([], []).
```

The last recursive call is:

```prolog
reverse_demo([], L3).
```

Prolog unifies the first arguments (`[]` with `[]`) and then the second arguments (`L3` with `[]`). Thus **`L3 = []`**. That empty list becomes the starting point for the upward `append_demo` operations.

The second sample query, `reverse_demo([], R)`, uses the **same base case immediately**. It returns `R = []` without entering the recursive clause.

## 5. Key ideas

- **Unification:** The head and tail of `[H|T]` are bound to the list's first element and remaining elements.
- **Recursion:** The program reverses the tail before it can construct the complete answer.
- **Intermediate variable:** The lecture's `L1` (named `RT` in the executable code) holds the reversed tail, not the final answer.
- **Base case:** `reverse_demo([], [])` stops the recursion and provides the initial empty result.
- **Returning results:** `append_demo` places each original head at the end of the already-reversed tail.

## 6. Practice

Predict the results before running these queries:

```prolog
?- reverse_demo([a,b], R).
?- reverse_demo([7], R).
?- reverse_demo([], R).
```

Then check your predictions in SWI-Prolog.

**Accessibility note:** The figure is accompanied by a complete text description so that its sequence, variable bindings, and results are available without relying on the image or its colors.
