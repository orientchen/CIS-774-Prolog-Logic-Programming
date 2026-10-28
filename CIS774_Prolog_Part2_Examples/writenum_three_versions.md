# Prolog `writenum`: Three Versions of Backtracking

## Learning objective

Compare **normal termination**, **infinite searching without further output**, and **infinite output**. The examples use the same number generator so that one small change at a time explains the different behavior.

## Shared number generator

Each version uses these two clauses:

```prolog
num(0).
num(X) :-
    num(Y),
    X is Y + 1.
```

`num(X)` can generate `0, 1, 2, 3, ...` on backtracking. In the examples below, `fail` forces Prolog to ask `num(X)` for another value.

## Version 1 — Prints 1 through 5 and terminates

```prolog
num(0).
num(X) :-
    num(Y),
    X is Y + 1.

writenum(I, J) :-
    num(X),
    I =< X,
    X =< J,
    write(X), nl,
    X = J, !,
    fail.
```

**Query:**

```prolog
?- writenum(1, 5).
```

**Output:**

```text
1
2
3
4
5
false.
```

**Explanation:**

1. `num(X)` generates numbers in ascending order.
2. `I =< X` and `X =< J` limit the printed values to 1 through 5.
3. For `X = 1` through `4`, the test `X = J` fails, so Prolog backtracks to `num(X)` for the next number.
4. At `X = 5`, `X = J` succeeds and `!` (cut) commits to this choice, preventing Prolog from returning to `num(X)` to generate 6 or more.
5. The final `fail` makes the overall query fail, but **the search terminates** because the cut removed the earlier alternatives.

**Key idea:** The cut stops further generation; `fail` explains the final `false.` result.

## Version 2 — Prints 1 through 5, then searches forever

**Change from Version 1:** Remove `X = J, !`.

```prolog
num(0).
num(X) :-
    num(Y),
    X is Y + 1.

writenum(I, J) :-
    num(X),
    I =< X,
    X =< J,
    write(X), nl,
    fail.
```

**Query:**

```prolog
?- writenum(1, 5).
```

**Visible output:**

```text
1
2
3
4
5
```

**Explanation:** After printing 5, `fail` triggers backtracking. `num(X)` generates 6, 7, 8, ... indefinitely. Every one of those values fails `X =< J`, so nothing more is printed. Prolog keeps searching and does **not** return to the `?-` prompt.

**Key idea:** An infinite computation does not necessarily produce infinite output.

## Version 3 — Prints an unbounded sequence

**Change from Version 2:** Remove `X =< J` as well.

```prolog
num(0).
num(X) :-
    num(Y),
    X is Y + 1.

writenum(I, J) :-
    num(X),
    I =< X,
    write(X), nl,
    fail.
```

**Query:**

```prolog
?- writenum(1, 5).
```

**Visible output (continues):**

```text
1
2
3
4
5
6
7
8
9
10
...
```

**Explanation:** There is no longer an upper-bound test. Each new value from `num(X)` is printed, and `fail` forces another attempt. The process continues until interrupted or stopped by a resource limit.

**Note:** `J` is unused in Version 3. It is kept only to make the three programs easy to compare. In a cleaned-up version, use `writenum(I)` instead.

## Side-by-side comparison

| Version | What changed? | Visible output | Does it terminate on its own? |
|---|---|---|---|
| 1 | Original: includes `X = J, !` | `1` through `5`, then `false.` | **Yes** |
| 2 | Remove `X = J, !` | `1` through `5`, then silence | **No** — infinite search |
| 3 | Also remove `X =< J` | `1, 2, 3, ...` | **No** — infinite output |

## In-class discussion

1. Why does Version 1 return `false.` even though it prints five numbers?
2. In Version 2, what is Prolog doing after it prints 5?
3. Which condition prevents Version 2 from printing 6?
4. Why is parameter `J` unnecessary in Version 3?

**Practical tip:** In SWI-Prolog, press **Ctrl+C** and choose **`a` (abort)** to interrupt a running query. If the program is already running, typing `halt.` will not stop it because Prolog is not waiting for a new query.
