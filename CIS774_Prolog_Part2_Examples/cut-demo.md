# Cut (`!`) and Controlled Search in Prolog

## Learning objectives

After completing these examples, students should be able to:

1. Explain how Prolog searches for solutions by backtracking.
2. Explain how the cut operator (`!`) prevents Prolog from reconsidering earlier choices.
3. Trace recursive calls that generate a finite range of integers.
4. Distinguish recursion, backtracking, cut, and deliberate failure (`fail/0`).
5. Explain how a cut can stop backtracking into an unbounded integer generator.

## Prolog program

The accompanying program is [cut-demo.pl](cut-demo.pl). Update it to contain the following complete code:

```prolog
% Demonstrate pruning.
choice(amy).
choice(bob).

first_choice(X) :- choice(X), !.
all_choices(X) :- choice(X).

% Finite integer generation using numerical bounds (no cut).
range_cut(I, J, I) :- I =< J.
range_cut(I, J, X) :-
    I < J,
    Next is I + 1,
    range_cut(Next, J, X).

% Slide 29: An unbounded integer generator.
num(0).
num(X) :-
    num(Y),
    X is Y + 1.

% Print numbers in a range; cut stops further generation at J.
writenum(I, J) :-
    num(X),
    I =< X,
    X =< J,
    write(X), nl,
    X = J, !,
    fail.
```

**Important clarification:** Although the predicate is named `range_cut/3`, its clauses contain **no `!` operator**. It uses a numerical bound and recursion to generate a finite sequence. The actual cut-for-termination example is `writenum/2`.

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
range_cut(I, J, X) :-
    I < J,
    Next is I + 1,
    range_cut(Next, J, X).
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

When the user presses `;` again, Prolog attempts the second clause for `range_cut(3, 3, X)`. Its condition `3 < 3` fails, so no further recursive call is made. Earlier calls have no remaining alternatives, and the search ends.

**This range example terminates because of its bounds, not because of a cut.**

## 4. Cut for termination: `writenum/2` (slide 29)

The slide uses an **unbounded** integer generator:

```prolog
num(0).
num(X) :- num(Y), X is Y + 1.
```

On backtracking, `num(X)` can generate `0`, `1`, `2`, `3`, and so on, without an upper limit. The `writenum/2` predicate uses this generator:

```prolog
writenum(I, J) :-
    num(X),
    I =< X,
    X =< J,
    write(X), nl,
    X = J, !,
    fail.
```

Run:

```prolog
?- writenum(1, 3).
```

Expected output (the final `false` is the query result, not a printed number):

```text
1
2
3
false.
```

### Step-by-step execution trace

```text
writenum(1, 3)
  |
  +-- num(X) generates X = 0
  |     +-- 1 =< 0 fails; backtrack to num(X)
  |
  +-- num(X) generates X = 1
  |     +-- 1 =< 1 succeeds; 1 =< 3 succeeds
  |     +-- write(1), nl   [prints 1]
  |     +-- 1 = 3 fails; backtrack to num(X)
  |
  +-- num(X) generates X = 2
  |     +-- bounds succeed
  |     +-- write(2), nl   [prints 2]
  |     +-- 2 = 3 fails; backtrack to num(X)
  |
  +-- num(X) generates X = 3
        +-- bounds succeed
        +-- write(3), nl   [prints 3]
        +-- 3 = 3 succeeds
        +-- ! executes; removes earlier choice points
        +-- fail executes; writenum/2 fails
              +-- cannot backtrack to num(X)
              +-- query ends with false
```

**Why are both `X = J` and `!` needed?**

- `X = J` is **unification**, not assignment. It succeeds only when the generated `X` equals the upper bound `J`.
- For values below `J`, `X = J` fails, causing backtracking to `num(X)` to generate the next number.
- When `X` reaches `J`, the cut (`!`) executes. It commits to the current search path and removes choice points created since entering this `writenum/2` clause, including those that would generate larger numbers.
- `fail` then deliberately fails. Because the cut removed the alternatives, Prolog cannot continue generating integers. The overall query returns `false`.

**Why does the original version without the cut loop?** If the code merely checks `X =< J`, a generated value greater than `J` fails that test, but Prolog can still backtrack to the unbounded `num(X)` and try a still larger value. The search never exhausts the generator.

**Important:** `write/1` and `nl/0` produce output that is not undone by backtracking. Thus the printed numbers remain visible even though the overall query fails.

### Optional: Make the query succeed after printing

The slide intentionally ends with `false`. To print the same numbers and obtain a successful overall query, add a second clause **after** the existing one:

```prolog
writenum(_, _).
```

With that optional clause, the query prints the numbers and then succeeds via the second clause. **Do not add it if you want to reproduce the slide's exact final `false`.**

## 5. Compare the examples

| Predicate | Main mechanism | Result for example query |
|---|---|---|
| `all_choices/1` | Ordinary backtracking | `amy`, then `bob` |
| `first_choice/1` | Cut prunes earlier alternatives | `amy` only |
| `range_cut/3` | Recursion plus numerical bounds; no cut | `1`, `2`, `3` |
| `writenum/2` | Unbounded generation, backtracking, cut, and deliberate failure | Prints `1`, `2`, `3`; query returns `false` |

## 6. Practice questions

1. Why does `all_choices(X)` return two solutions while `first_choice(X)` returns only one?
2. Which choice point does the cut remove in `first_choice/1`?
3. Would placing `!` before `choice(X)` prevent the `bob` solution? Explain.
4. Trace `range_cut(2, 4, X)` and list each solution in order.
5. Why does `range_cut(3, 3, X)` return `3` but not call `range_cut(4, 3, X)`?
6. Does `range_cut/3` actually use a cut? Identify the condition that ensures termination.
7. In `writenum(1, 3)`, why does `X = J` fail for `X = 1` and `X = 2` but succeed for `X = 3`?
8. What would happen if you removed `!` from `writenum/2` while keeping `fail`?
9. Why does `writenum(1, 3)` print all three numbers but return `false`?
10. What changes if you add the optional second clause `writenum(_, _).`?

## Accessibility note

All traces are presented as text, with explicit descriptions of the order of calls, choices, backtracking, and termination. No diagram or color interpretation is required to understand the examples.
