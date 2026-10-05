# Complete Derivation Using Unification

## Rules and Facts

```text
Rule 1: ancestor(X, Y) ← parent(X, Y).
Rule 2: ancestor(X, Y) ← parent(X, Z), ancestor(Z, Y).

Fact 1: parent(alice, charlie).
Fact 2: parent(charlie, bob).
```

## Query

```text
← ancestor(alice, bob)
```

## Step 1 — Unify the Query with Rule 2

Match the query goal with the head of Rule 2:

```text
ancestor(alice, bob) = ancestor(X, Y)
```

Compare corresponding arguments:

```text
X = alice
Y = bob
```

Substitute `X = alice` and `Y = bob` into the entire rule:

```text
ancestor(alice, bob) ← parent(alice, Z), ancestor(Z, bob)
```

The rule head now matches the query goal. Cancel `ancestor(alice, bob)`:

```text
← parent(alice, Z), ancestor(Z, bob)
```

## Step 2 — Unify the First Goal with Fact 1

Match the first goal with Fact 1:

```text
parent(alice, Z) = parent(alice, charlie)
```

Compare corresponding arguments:

```text
alice = alice
Z = charlie
```

Therefore:

```text
Z = charlie
```

Substitute `Z = charlie` into the **entire current goal**:

```text
← parent(alice, charlie), ancestor(charlie, bob)
```

The first goal now matches Fact 1. Cancel `parent(alice, charlie)`:

```text
← ancestor(charlie, bob)
```

## Step 3 — Unify the Remaining Goal with Rule 1

Match the remaining goal with the head of Rule 1:

```text
ancestor(charlie, bob) = ancestor(X, Y)
```

Compare corresponding arguments:

```text
X = charlie
Y = bob
```

Substitute `X = charlie` and `Y = bob` into the entire rule:

```text
ancestor(charlie, bob) ← parent(charlie, bob)
```

The rule head now matches the current goal. Cancel `ancestor(charlie, bob)`:

```text
← parent(charlie, bob)
```

## Step 4 — Match the Remaining Goal with Fact 2

Compare the remaining goal with Fact 2:

```text
parent(charlie, bob) = parent(charlie, bob)
```

They are already identical, so no variable substitution is needed.

Cancel the matched goal:

```text
←
```

No goals remain. Therefore, the query **succeeds**.

```text
Success
```

## Unification Pattern

**Unify → Substitute → Cancel → New Goal**

Unification sets variables equal to terms so that statements become identical. After substitution, the matched goal can be canceled, and the derivation continues with the remaining goal(s).
