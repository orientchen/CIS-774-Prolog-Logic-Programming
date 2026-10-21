# List unification

Part 2: list notation and unification.

## Learning objectives

- Explain how `[H|T]` separates a list into its first element and remaining elements.
- Explain how `[X,Y|Z]` matches the first two elements and the remaining list.
- Trace variable bindings during unification.
- Distinguish unification from recursion.

## Running the examples

Load the accompanying Prolog program in SWI-Prolog:

```prolog
?- ['list-unification.pl'].
```

At the SWI-Prolog prompt, enter queries without the leading `?-`.

```prolog
example_head_tail([1,2,3], H, T).
example_two_heads([1,2,3], X, Y, Z).
[H|T] = [1,2,3].
[X,Y|Z] = [1,2,3].
```

## Trace 1: Head and tail

Query:

```prolog
?- [H|T] = [1,2,3].
```

```text
Pattern:  [ H | T ]
List:     [ 1 | 2, 3 ]

Step 1: Match the first element: H = 1.
Step 2: Match the remaining list: T = [2,3].

Result: H = 1, T = [2,3].
```

The vertical bar `|` separates the first element (head) from the remaining list (tail). The tail is itself a list, even if it contains only one element or is empty.

## Trace 2: Two elements and the remaining list

Query:

```prolog
?- [X,Y|Z] = [1,2,3].
```

```text
Pattern:  [ X, Y | Z ]
List:     [ 1, 2 | [3] ]

Step 1: Match the first element: X = 1.
Step 2: Match the second element: Y = 2.
Step 3: Match the remaining list: Z = [3].

Result: X = 1, Y = 2, Z = [3].
```

Note that `Z = [3]`, **not** `Z = 3`: the part after `|` is a list.

## Trace 3: Empty tail

```prolog
?- [H|T] = [7].
```

```text
Step 1: H = 7.
Step 2: No elements remain, so T = [].

Result: H = 7, T = [].
```

## When unification fails

```prolog
?- [X,Y|Z] = [1].
false.
```

The pattern requires at least two elements, but `[1]` contains only one.

## Is this recursion?

**No.** These examples perform one structural match between two list terms. They do not call a predicate repeatedly, and there is no recursive base case. For actual recursive list processing, see the separate `append-lists` and `reverse-lists` examples.

## Practice questions

Predict the bindings or explain why unification fails:

```prolog
?- [A|B] = [10,20,30].
?- [A,B|C] = [10,20].
?- [A|B] = [].
?- [A,B|C] = [10,20,30,40].
```

All traces are provided as selectable text, with no image required to understand the steps.
