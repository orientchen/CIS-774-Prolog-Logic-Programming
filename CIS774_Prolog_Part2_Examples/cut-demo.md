# Cut (!) and controlled search

Part 2 cut and control structures. Load: `[cut-demo].`

```prolog
all_choices(X).
first_choice(X).
range_cut(1,3,X).
```

Press `;` after each solution. `all_choices/1` gives `amy` and `bob`. `first_choice/1` gives only `amy`: `!` commits to the choice made before it. `range_cut/3` demonstrates a *safe finite alternative* for generating 1 through 3 using an explicit bound (not a direct transcription of the lecture's infinite-generator program).

**Caution:** A cut changes which solutions can be reached. Its placement matters; compare `choice(X), !` with `!, choice(X)` and reason about the scope of the cut.
