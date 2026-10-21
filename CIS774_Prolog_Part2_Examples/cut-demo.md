# Cut (`!`) and Controlled Search in Prolog

## Learning objectives

After completing these examples, students should be able to:

1. Explain how Prolog searches for solutions by backtracking.
2. Explain how the cut operator (`!`) prevents Prolog from reconsidering earlier choices.
3. Trace recursive calls that generate a finite range of integers.
4. Distinguish recursion from backtracking and cut.

## Prolog program

The accompanying program is [cut-demo.pl](cut-demo.pl):

```prolog
% Demonstrate pruning.
choice(amy).
choice(bob).
first_choice(X) :- choice(X), !.
all_choices(X) :- choice(X).

% Finite integer generation with a cut at the upper bound.
range_cut(I, J, I) :- I =< J.
range_cut(I, J, X) :- I < J, Next is I+1, range_cut(Next, J, X).
```

**Important clarification:** Although the predicate is named `range_cut/3` and its source comment mentions a cut, its actual clauses contain **no `!` operator**. It uses a numerical bound and recursion to generate a finite sequence.

Load the program in SWI-Prolog:

```prolog
?- ['cut-demo.pl'].
```

## 1. Normal backtracking: `all_choices/1`

Run:

```prolog
?- all_choices(X).
```

Execution trace:

```text
all_choices(X)
  |
  +-- choice(X)
        |
        +-- choice(amy)  -> X = amy   [first solution]
        |
        +-- user enters ; to request another solution
        |
        +-- backtrack to choice(X)
        |
        +-- choice(bob)  -> X = bob   [second solution]
        |
        +-- no more choice/1 facts
```

Prolog tries facts in source order. On `;`, it returns to the remaining choice point and finds `bob`.

## 2. Backtracking with cut: `first_choice/1`

Run:

```prolog
?- first_choice(X).
```

Execution trace:

```text
first_choice(X)
  |
  +-- choice(X)
  |     |
  |     +-- choice(amy) -> X = amy
  |     |
  |     +-- choice(bob) [alternative exists, not yet tried]
  |
  +-- ! (cut executes)
  |     |
  |     +-- discards the alternative choice(bob)
  |
  +-- succeeds with X = amy
        |
        +-- user enters ;
        +-- no additional solution
```

The cut does not mean that `bob` is false. It prevents this particular call to `first_choice/1` from backtracking to the alternative `choice(bob)` fact.

### Why the position of `!` matters

Compare these two hypothetical definitions:

```prolog
first_choice(X) :- choice(X), !.
cut_before_choice(X) :- !, choice(X).
```

- In `first_choice/1`, the cut executes **after** `choice(X)` has selected `amy`. It removes the remaining alternatives of that earlier call.
- In `cut_before_choice/1`, the cut executes **before** `choice(X)`. It does not remove the alternatives created later by `choice(X)`, so both `amy` and `bob` can still be produced.

## 3. Recursive range generation: `range_cut/3`

Run:

```prolog
?- range_cut(1, 3, X).
```

The two clauses are:

```prolog
range_cut(I, J, I) :- I =< J.
range_cut(I, J, X) :- I < J, Next is I+1, range_cut(Next, J, X).
```

The first clause provides a solution using the current lower bound. The second clause advances that bound and recursively searches for later solutions.

### Recursion and backtracking trace

```text
range_cut(1, 3, X)
  |
  +-- Clause 1: 1 =< 3 succeeds
  |     -> X = 1                 [first solution]
  |
  +-- ; requests another solution
  |
  +-- Clause 2: 1 < 3, Next = 2
        |
        +-- range_cut(2, 3, X)
              |
              +-- Clause 1: 2 =< 3 succeeds
              |     -> X = 2     [second solution]
              |
              +-- ; requests another solution
              |
              +-- Clause 2: 2 < 3, Next = 3
                    |
                    +-- range_cut(3, 3, X)
                          |
                          +-- Clause 1: 3 =< 3 succeeds
                          |     -> X = 3  [third solution]
                          |
                          +-- ; requests another solution
                          |
                          +-- Clause 2: 3 < 3 fails
                          +-- no more solutions
```

### What happens after `X = 3`?

When the user presses `;` again, Prolog attempts the second clause for `range_cut(3,3,X)`. Its condition `3 < 3` fails, so no further recursive call is made. Earlier calls have no remaining alternatives, and the search ends.

**This range example terminates because of its bounds, not because of a cut.**

## 4. Compare the examples

| Predicate | Main mechanism | Solutions for example query |
|---|---|---|
| `all_choices/1` | Ordinary backtracking | `amy`, `bob` |
| `first_choice/1` | Cut prunes earlier alternatives | `amy` only |
| `range_cut/3` | Recursion plus numerical bounds | `1`, `2`, `3` |

## 5. Practice questions

1. Why does `all_choices(X)` return two solutions while `first_choice(X)` returns only one?
2. Which choice point does the cut remove in `first_choice/1`?
3. Would placing `!` before `choice(X)` prevent the `bob` solution? Explain.
4. Trace `range_cut(2, 4, X)` and list each solution in order.
5. Why does `range_cut(3, 3, X)` return `3` but not call `range_cut(4, 3, X)`?
6. Does `range_cut/3` actually use a cut? Identify the condition that ensures termination.

## Accessibility note

All traces are presented as text, with explicit descriptions of the order of calls, choices, backtracking, and termination. No diagram or color interpretation is required to understand the examples.
