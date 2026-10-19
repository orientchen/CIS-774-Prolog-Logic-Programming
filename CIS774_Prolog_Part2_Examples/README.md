# CIS 774 — Prolog Logic Programming: Part 2 Examples

These examples accompany **Chapter 4: Logic Programming — Part 2**. They extend the repository's earlier `ancestor`, `horse`, and `gcd` examples and illustrate unification, recursion, Prolog's depth-first search, backtracking, `fail`, and cut (`!`).

Each topic includes a **`.pl` source file** and a **`.md` handout** with example queries and explanations. Read the corresponding handout as you run the code.

## Example index

| Order | Program | Handout | Topic |
|---|---|---|---|
| 1 | [list-unification.pl](list-unification.pl) | [list-unification.md](list-unification.md) | Matching lists with `[H\|T]` and binding variables |
| 2 | [append-lists.pl](append-lists.pl) | [append-lists.md](append-lists.md) | Recursive append; finding list splits by backtracking |
| 3 | [reverse-lists.pl](reverse-lists.pl) | [reverse-lists.md](reverse-lists.md) | Recursive reverse built using append |
| 4 | [search-backtracking.pl](search-backtracking.pl) | [search-backtracking.md](search-backtracking.md) | Clause order, depth-first resolution, and backtracking |
| 5 | [printpieces.pl](printpieces.pl) | [printpieces.md](printpieces.md) | Enumerating list splits with `fail` |
| 6 | [cut-demo.pl](cut-demo.pl) | [cut-demo.md](cut-demo.md) | Using `!` to commit to a choice |
| 7 | [arithmetic-gcd.pl](arithmetic-gcd.pl) | [arithmetic-gcd.md](arithmetic-gcd.md) | Arithmetic evaluation using `is` and Euclid's GCD algorithm |

## Running the programs in GitHub Codespaces

The commands below assume you opened the repository in Codespaces and your **terminal is in the repository root**.

1. Start SWI-Prolog in the terminal:

   ```bash
   swipl
   ```

2. At the Prolog prompt (`?-`), load an example **using its folder path**:

   ```prolog
   ?- ['CIS774_Prolog_Part2_Examples/append-lists.pl'].
   ```

3. Run a query:

   ```prolog
   ?- append_demo([1,2], [3,4], Z).
   ```

   Expected result:

   ```text
   Z = [1,2,3,4].
   ```

4. Enter `;` when Prolog offers another solution to explore backtracking. Press Enter to stop requesting additional solutions.

5. To leave SWI-Prolog, enter:

   ```prolog
   ?- halt.
   ```

**Important:** The `?-` shown above is the Prolog prompt; **do not type it**. End each query with a period (`.`).

### Alternative: work inside the examples folder

In the Codespaces terminal:

```bash
cd CIS774_Prolog_Part2_Examples
swipl
```

Then the shorter loading command works:

```prolog
?- ['append-lists.pl'].
```

**Only the file-loading command changes with the folder location.** Predicate calls such as `append_demo([1,2], [3,4], Z).` remain the same.

## Suggested study sequence

1. **List unification:** Match the head and tail of a list; identify variable substitutions.
2. **Append:** Trace the recursive base case and the return from recursive calls. Try a query with the result list fixed to see multiple splits.
3. **Reverse:** Follow how recursion and append combine to construct a reversed list.
4. **Search and backtracking:** Observe left-to-right subgoals and top-to-bottom clause selection. Request more answers using `;`.
5. **`printpieces` and `fail`:** See how intentional failure forces Prolog to find another list split.
6. **Cut (`!`):** Compare `first_choice/1` with `all_choices/1` to see how cut prunes alternative solutions.
7. **Arithmetic and GCD:** Review `is`, `mod`, and recursive computation.

## Notes on Prolog behavior

- **Unification (`=`) is not arithmetic evaluation.** Use `is` when you want Prolog to evaluate an arithmetic expression.
- **Clause order matters.** Prolog normally selects the leftmost subgoal and tries matching clauses in their written order, using depth-first search.
- **Backtracking** explores alternative solutions. A semicolon (`;`) at the answer prompt asks Prolog to continue searching.
- **`fail`** deliberately makes the current branch fail; `printpieces.pl` uses it to print all list splits.
- **Cut (`!`)** commits to choices made so far in the current predicate invocation. In `cut-demo.pl`, `first_choice/1` returns only the first matching choice.
- The `range_cut/3` predicate in `cut-demo.pl` is a **finite recursive range generator**; despite its name, it does not itself use the cut operator. Use `first_choice/1` to study the actual cut behavior.

## Relationship to the lecture materials

The examples are based on the Part 2 lecture and the accompanying handouts on Prolog's search mechanism, recursive `append`, and `printpieces`. The `.md` files give more detailed queries and step-by-step explanations for individual topics.
