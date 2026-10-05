# Resolution and Unification — `legs(horse, 4)`

## Rules and Facts

```text
Rule 1: legs(x, 2) ← mammal(x), arms(x, 2).
Rule 2: legs(x, 4) ← mammal(x), arms(x, 0).

Fact 1: mammal(horse).
Fact 2: arms(horse, 0).
```

## Query

```text
← legs(horse, 4)
```

We want to determine whether `legs(horse, 4)` can be derived from the rules and facts.

---

## Step 1 — Unify the Query with Rule 2

Match the query goal:

```text
legs(horse, 4)
```

with the head of Rule 2:

```text
legs(x, 4)
```

Compare corresponding arguments:

```text
x = horse
4 = 4
```

Therefore, the unifier is:

```text
x = horse
```

Substitute `x = horse` into the **entire rule**:

```text
legs(horse, 4) ← mammal(horse), arms(horse, 0)
```

The rule head now matches the query goal.

Resolve/cancel `legs(horse, 4)`:

```text
← mammal(horse), arms(horse, 0)
```

---

## Step 2 — Resolve the First Goal with Fact 1

Take the first remaining goal:

```text
mammal(horse)
```

Compare it with Fact 1:

```text
mammal(horse)
```

They are already identical, so no variable substitution is needed.

Cancel the matched goal:

```text
← arms(horse, 0)
```

---

## Step 3 — Resolve the Remaining Goal with Fact 2

Compare the remaining goal:

```text
arms(horse, 0)
```

with Fact 2:

```text
arms(horse, 0)
```

They are already identical, so no variable substitution is needed.

Cancel the matched goal:

```text
←
```

There are no goals remaining.

```text
Success
```

Therefore:

```text
legs(horse, 4)
```

is derived from the rules and facts.

---

## Complete Derivation

```text
← legs(horse, 4)

← mammal(horse), arms(horse, 0)
   [x = horse, using Rule 2]

← arms(horse, 0)
   [resolve with mammal(horse)]

←
   [resolve with arms(horse, 0)]

Success
```

## Resolution and Unification Pattern

```text
Unify → Substitute → Resolve/Cancel → New Goal
```

**Unification** determines the substitutions needed to make expressions match, such as `x = horse`.

**Resolution** uses the matching rule or fact to replace or eliminate a goal.

Unification and resolution work together, but they are not the same operation.
