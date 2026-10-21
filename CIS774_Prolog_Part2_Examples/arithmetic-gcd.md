
# Arithmetic and GCD in Prolog

## Learning objectives

After working through this example, students should be able to:

1. Explain the difference between `is` and `=` in Prolog.
2. Understand how the Euclidean algorithm calculates the greatest common divisor (GCD).
3. Trace recursive calls until the base case is reached.
4. Explain how the result is returned through the recursive calls.

## 1. Arithmetic evaluation versus unification

Prolog distinguishes arithmetic evaluation from term unification.

### Arithmetic evaluation using `is`

```prolog
?- X is 2+3.
X = 5.
```

The `is` operator evaluates the expression on its right-hand side and unifies the result with `X`.

### Unification using `=`

```prolog
?- X = 2+3.
X = 2+3.
```

The `=` operator unifies terms without evaluating arithmetic expressions.

**Key difference:**

- `is` evaluates arithmetic expressions.
- `=` performs unification without arithmetic evaluation.

## 2. Greatest Common Divisor (GCD)

The greatest common divisor of two positive integers is the largest positive integer that divides both numbers without a remainder.

For example:

- Divisors of 12: 1, 2, 3, 4, 6, 12
- Divisors of 8: 1, 2, 4, 8

Therefore:

```text
gcd(12, 8) = 4
```

### Euclidean algorithm

The Euclidean algorithm uses the following rule:

```text
gcd(U, V) = gcd(V, U mod V)
```

When `V = 0`, the recursion stops:

```text
gcd(U, 0) = U
```

## 3. Prolog implementation

The existing repository file `gcd.pl` provides the GCD implementation.

The following clauses illustrate the recursive algorithm using the predicate `gcd_demo/3`:

```prolog
gcd_demo(U, 0, U).

gcd_demo(U, V, G) :-
    V \= 0,
    R is U mod V,
    gcd_demo(V, R, G).
```

### Explanation

**First clause — Base case**

```prolog
gcd_demo(U, 0, U).
```

When the second argument is zero, the greatest common divisor is the first argument.

**Second clause — Recursive case**

```prolog
gcd_demo(U, V, G) :-
    V \= 0,
    R is U mod V,
    gcd_demo(V, R, G).
```

1. `V \= 0` checks that the second argument is not zero.
2. `R is U mod V` calculates the remainder.
3. `gcd_demo(V, R, G)` recursively calculates the GCD.

## 4. Recursion trace

Consider the query:

```prolog
?- gcd_demo(12, 8, G).
```

### Recursive calls

```text
gcd_demo(12, 8, G)
│
│  12 mod 8 = 4
│
└── gcd_demo(8, 4, G)
    │
    │  8 mod 4 = 0
    │
    └── gcd_demo(4, 0, G)
        │
        └── Base case: G = 4
```

### Step-by-step execution

**Step 1: Initial call**

```prolog
gcd_demo(12, 8, G)
```

Since `8 \= 0`, Prolog uses the recursive clause.

Calculate:

```text
R = 12 mod 8 = 4
```

The next call is:

```prolog
gcd_demo(8, 4, G)
```

**Step 2: Second recursive call**

```prolog
gcd_demo(8, 4, G)
```

Since `4 \= 0`, Prolog again uses the recursive clause.

Calculate:

```text
R = 8 mod 4 = 0
```

The next call is:

```prolog
gcd_demo(4, 0, G)
```

**Step 3: Base case**

```prolog
gcd_demo(4, 0, G)
```

This matches the first clause:

```prolog
gcd_demo(U, 0, U).
```

Here:

```text
U = 4
G = 4
```

The base case succeeds.

### Returning from recursion

After reaching the base case, the recursive calls complete in reverse order.

```text
gcd_demo(4, 0, G)
    │
    └── G = 4
         │
         ▼
gcd_demo(8, 4, G)
    │
    └── succeeds with G = 4
         │
         ▼
gcd_demo(12, 8, G)
    │
    └── succeeds with G = 4
```

**Final result:**

```prolog
G = 4.
```

The same variable `G` is passed through the recursive calls. The base case binds `G` to `4`, and that binding is retained as the earlier calls complete.

## 5. Important observations

- The recursive clause reduces the problem by replacing `(U, V)` with `(V, U mod V)`.
- Each recursive call moves closer to the base case.
- Recursion stops when the second argument becomes zero.
- The base case determines the final value of `G`.
- This example demonstrates recursion and unification. It does not require backtracking to find the first solution.

## 6. Practice questions

1. What is the difference between `X is 2+3` and `X = 2+3`?
2. Why is `V \= 0` checked before calculating `U mod V`?
3. What is the base case of `gcd_demo/3`?
4. Trace the recursive calls for:

   ```prolog
   ?- gcd_demo(18, 12, G).
   ```

5. Trace the recursive calls for:

   ```prolog
   ?- gcd_demo(24, 9, G).
   ```

6. Explain why the same variable `G` is used throughout the recursive calls.

## 7. Running the example

Load the existing `gcd.pl` file in SWI-Prolog.

If that file defines `gcd_demo/3`, run:

```prolog
?- gcd_demo(12, 8, G).
```

Expected result:

```prolog
G = 4.
```

**Note:** If your `gcd.pl` uses the predicate name `gcd/3` instead, use that name in the query or add the `gcd_demo/3` clauses shown above.
