# Arithmetic and gcd

Extends the existing repository `gcd.pl` and Part 2's arithmetic section. Load: `[arithmetic-gcd].`

```prolog
X is 2+3.
X = 2+3.
gcd_demo(12,8,G).
```

`is` evaluates arithmetic; `=` unifies terms without evaluating the expression.

GCD trace: `gcd_demo(12,8,G)` computes remainder `4`; then `gcd_demo(8,4,G)` computes `0`; base case `gcd_demo(4,0,4)` gives `G=4`.
