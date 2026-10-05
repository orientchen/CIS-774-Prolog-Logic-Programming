# CIS-774-Prolog-Logic-Programming

Prolog Logic Programming examples for CIS 774 Programming Paradigms.

## Running the Prolog Example in GitHub Codespaces

### 1. Create a Codespace

From this GitHub repository:

1. Click **Code**.
2. Select **Codespaces**.
3. Click **Create codespace on main**.
4. Wait for the Codespace to finish setting up.

SWI-Prolog is installed automatically.

### 2. Start SWI-Prolog

In the terminal, type:

```bash
swipl
```

You will see the Prolog prompt:

```text
?-
```

> **Note:** `?-` is displayed by Prolog. Do not type `?-` yourself.

### 3. Load the Prolog Program

At the Prolog prompt, type:

```prolog
[ancestor].
```

You should see:

```text
true.
```

This loads `ancestor.pl`.

### 4. Run a Query

To check whether Alice is an ancestor of Bob, type:

```prolog
ancestor(alice, bob).
```

Result:

```text
true.
```

### 5. Query with a Variable

To find Alice's descendants, type:

```prolog
ancestor(alice, X).
```

Prolog first returns:

```text
X = charlie
```

Type a semicolon (`;`) to ask Prolog for another solution. Prolog then finds:

```text
X = bob
```

This demonstrates how Prolog uses unification and backtracking to find multiple solutions.

### 6. Exit SWI-Prolog

Type:

```prolog
halt.
```

This returns you to the regular terminal.

## Files

- `ancestor.pl` — Prolog program containing the `parent` facts and `ancestor` rules.
- `ancestor-unification.md` — Step-by-step derivation showing unification, substitution, and goal resolution.
- `.devcontainer/devcontainer.json` — GitHub Codespaces configuration that installs SWI-Prolog automatically.
