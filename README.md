# Linear Diophantine Equation Solver (Racket)

This repository contains a single Racket program that solves **Linear Diophantine Congruence Equations** of the form:
`Ax ≡ C (mod m)`
The program outputs **all possible congruence class solutions** to the given equation, if they exist.
## Overview
Given integers `A`, `C`, and modulus `m`, the code computes all integers `x` satisfying `Ax ≡ C(mod m)`
That is, it finds all `x` that make `(A * x - C)` a multiple of `m`.
The solver performs:
1. **Validation** — Checks whether solutions exist.
2. **Particular solution computation** — Uses the Extended Euclidean Algorithm to find one valid solution.
3. **General solution generation** — Produces all congruence class representatives of the solution set.
## How It Works

The main function of interest is:
```Racket
(mat a c m)
```
### Input
- `a`: Integer coefficient (A)
- `c`: Integer constant (C)
- `m`: Natural number modulus (m)
### Output
A **list of integers** representing all congruence class solutions, or a **string message** if
- No solutions exist.
- Invalid parameters are supplied.
### Example
```Racket
> (mat 4 8 12)
'(2 5 8 11)
```
Explanation:  
The equation `4x ≡ 8 (mod 12)` has solutions where `x∈{2,5,8,11}`
## Function Summary

| Function            | Purpose                                                                         |
| ------------------- | ------------------------------------------------------------------------------- |
| `simplify`          | Reduces a number to its congruence class modulo `m`.                            |
| `get-particular`    | Implements the extended Euclidean algorithm to find a particular solution.      |
| `mk-sol-list`       | Generates all solutions in the congruence class based on a particular solution. |
| `primary-solutions` | Handles logic for finding the main solution set or error messages.              |
| `finalize`          | Simplifies each result to its modulo class and cleans the output.               |
| `mat`               | **Main user-facing function** that combines all the above steps.                |
## Mathematical Background
A linear congruence `Ax ≡ C (mod m)` **iff** `gcd⁡(A,m)∣C`

If `d = gcd⁡(A,m)`, then there are `d` distinct solutions modulo `m`, each differing by `m/d`​.

This implementation computes one particular solution via the **Extended Euclidean Algorithm**, then enumerates all congruence class representatives.

# Author
Developed by **Paarth Pasari**  
AI, Programming, and Mathematics Enthusiast  
Student at the University of Waterloo
