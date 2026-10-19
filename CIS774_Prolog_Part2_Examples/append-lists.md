# Recursive append and backward queries

Part 2 append example; also extends *Unification append(X,Y,Z)_rev.docx*.

Load: `[append-lists].`

```prolog
append_demo([], [1,2,3], Z).
append_demo([1,2], [3,4], Z).
append_demo(X, Y, [1,2]).
```

The second query produces `Z = [1,2,3,4]`. The third enumerates splits: `([], [1,2])`, `([1], [2])`, `([1,2], [])`; press `;` for more.

## Step-by-step recursion

1. `append_demo([1,2],[3,4],Z)` matches `[A|B]=[1,2]`, so `A=1`, `B=[2]`, `Z=[1|W1]`.
2. `append_demo([2],[3,4],W1)` sets `A=2`, `B=[]`, `W1=[2|W2]`.
3. Base case `append_demo([],[3,4],W2)` gives `W2=[3,4]`.
4. Substitute upward: `W1=[2,3,4]`, then `Z=[1,2,3,4]`.

**Note:** `W1` and `W2` are separate variables for separate recursive calls. This makes the return substitutions clearer than reusing `W` in each frame.
