# Resolution and Unification — GCD Example

## Rules

```text
Rule 1: gcd(u, 0, u).

Rule 2: gcd(u, v, w) ← not zero(v), gcd(v, u mod v, w).
```

## Goal

```text
← gcd(15, 10, x)
```

We want to determine the value of `x`.

---

## Step 1 — Try Rule 1

Compare the goal:

```text
gcd(15, 10, x)
```

with Rule 1:

```text
gcd(u, 0, u)
```

Compare corresponding arguments:

```text
u = 15
10 = 0     ← cannot match
x = u
```

Since `10` cannot unify with `0`, **Rule 1 fails**.

Therefore, try Rule 2.

---

## Step 2 — Unify the Goal with Rule 2

Compare:

```text
gcd(15, 10, x)
```

with the head of Rule 2:

```text
gcd(u, v, w)
```

Unification gives:

```text
u = 15
v = 10
w = x
```

Substitute these values into the entire rule:

```text
gcd(15, 10, x)
    ← not zero(10),
      gcd(10, 15 mod 10, x)
```

Resolve/cancel the matching goal `gcd(15, 10, x)`:

```text
← not zero(10), gcd(10, 15 mod 10, x)
```

---

## Step 3 — Evaluate the Conditions

Since:

```text
zero(10)
```

is false,

```text
not zero(10)
```

is true.

Also:

```text
15 mod 10 = 5
```

Therefore:

```text
← gcd(10, 5, x)
```

This is the new subgoal.

---

## Step 4 — Try Rule 1 Again

Compare:

```text
gcd(10, 5, x)
```

with:

```text
gcd(u, 0, u)
```

The second arguments would require:

```text
5 = 0
```

which fails.

Therefore, use Rule 2 again.

---

## Step 5 — Unify `gcd(10, 5, x)` with Rule 2

Compare:

```text
gcd(10, 5, x)
```

with:

```text
gcd(u, v, w)
```

Unification gives:

```text
u = 10
v = 5
w = x
```

Substitute into Rule 2:

```text
gcd(10, 5, x)
    ← not zero(5),
      gcd(5, 10 mod 5, x)
```

Resolve/cancel `gcd(10, 5, x)`:

```text
← not zero(5), gcd(5, 10 mod 5, x)
```

---

## Step 6 — Evaluate the Conditions Again

Since:

```text
zero(5)
```

is false,

```text
not zero(5)
```

is true.

Also:

```text
10 mod 5 = 0
```

Therefore the new subgoal is:

```text
← gcd(5, 0, x)
```

---

## Step 7 — Unify with Rule 1

Now compare:

```text
gcd(5, 0, x)
```

with Rule 1:

```text
gcd(u, 0, u)
```

Compare corresponding arguments:

```text
u = 5
0 = 0
x = u
```

Since:

```text
u = 5
```

we obtain:

```text
x = 5
```

The goal is completely resolved:

```text
←
```

No goals remain.

```text
Success
```

Therefore:

```text
gcd(15, 10, 5)
```

and the answer to the original query is:

```text
x = 5
```

---

## Complete Derivation

```text
← gcd(15, 10, x)

Rule 1 fails because 10 ≠ 0.

← not zero(10), gcd(10, 15 mod 10, x)
   [u = 15, v = 10, w = x; use Rule 2]

← gcd(10, 5, x)
   [not zero(10) is true; 15 mod 10 = 5]

Rule 1 fails because 5 ≠ 0.

← not zero(5), gcd(5, 10 mod 5, x)
   [u = 10, v = 5, w = x; use Rule 2]

← gcd(5, 0, x)
   [not zero(5) is true; 10 mod 5 = 0]

←
   [use Rule 1: u = 5 and x = u, so x = 5]

Success: x = 5
```

## Key Idea

```text
Unify → Substitute → Resolve → Simplify → Repeat
```

**Unification** finds substitutions that make the current goal match a rule head.

**Resolution** applies the matching rule and replaces the current goal with the rule body.

The recursive process continues until the base rule `gcd(u, 0, u)` is reached.
