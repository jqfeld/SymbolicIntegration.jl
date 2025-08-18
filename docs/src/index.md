# SymbolicIntegration.jl

```@meta
CurrentModule = SymbolicIntegration
```

SymbolicIntegration.jl provides Julia implementations of symbolic integration algorithms.

The front-end (i.e., the user interface) supports both [Symbolics.jl](https://docs.sciml.ai/Symbolics/stable/) and [SymbolicUtils.jl](https://symbolicutils.juliasymbolics.org/).
The actual integration algorithms are implemented in a generic way using [AbstractAlgebra.jl](https://nemocas.github.io/AbstractAlgebra.jl/dev/).
Some algorithms require [Nemo.jl](https://nemocas.github.io/Nemo.jl/dev/) for calculations with algebraic numbers.

SymbolicIntegration.jl is based on the algorithms from the book

> Manuel Bronstein, [Symbolic Integration I: Transcentental Functions](https://link.springer.com/book/10.1007/b138171), 2nd ed, Springer 2005,

for which a pretty complete set of reference implementations is provided.

Currently, SymbolicIntegration.jl can integrate:
- Rational functions
- Integrands involving transcendental elementary functions like `exp`, `log`, `sin`, etc.

As in the book, integrands involving algebraic functions like `sqrt` and non-integer powers are not treated.

!!! note
    SymbolicIntegration.jl is still in an early stage of development and should not be expected to run stably in all situations.
    It comes with absolutely no warranty whatsoever.

## Installation

```julia
julia> using Pkg; Pkg.add("SymbolicIntegration")
```

## Quick Start

```julia
# Using Symbolics.jl (recommended)
using SymbolicIntegration, Symbolics

@variables x

# Basic polynomial integration
integrate(x^2, x)  # Returns (1//3)*(x^3)

# Rational function integration  
f = (x^3 + x^2 + x + 2)/(x^4 + 3*x^2 + 2)
integrate(f, x)  # Returns (1//2)*log(2 + x^2) + atan(x)

# Transcendental functions
integrate(exp(x), x)    # Returns exp(x)
integrate(log(x), x)    # Returns -x + x*log(x)
integrate(1/x, x)       # Returns log(x)

# Complex root integration (arctangent cases)
integrate(1/(x^2 + 1), x)  # Returns atan(x)

# More complex examples
f = 1/(x*log(x))
integrate(f, x)  # Returns log(log(x))
```

You can also use SymbolicUtils.jl directly:
```julia
using SymbolicIntegration, SymbolicUtils
@syms x
integrate(x^2, x)  # Same functionality
```

## Algorithm Coverage

This package implements the complete suite of algorithms from Bronstein's book:

- **Rational Function Integration** (Chapter 2)
  - Hermite reduction
  - Rothstein-Trager method for logarithmic parts
  - Complexification and real form conversion

- **Transcendental Function Integration** (Chapters 5-6)  
  - Risch algorithm for elementary functions
  - Differential field towers
  - Primitive and hyperexponential cases

- **Algebraic Function Integration** (Future work)
  - Currently not implemented

## Contributing

We welcome contributions! Please see the [Symbolics.jl contributing guidelines](https://docs.sciml.ai/Symbolics/stable/contributing/).

## Citation

If you use SymbolicIntegration.jl in your research, please cite:

```bibtex
@software{SymbolicIntegration.jl,
  author = {Harald Hofstätter and contributors},
  title = {SymbolicIntegration.jl: Symbolic Integration for Julia},
  url = {https://github.com/JuliaSymbolics/SymbolicIntegration.jl},
  year = {2023-2025}
}
```

## Table of Contents

```@contents
Pages = [
    "manual/getting_started.md",
    "manual/basic_usage.md", 
    "manual/rational_functions.md",
    "manual/transcendental_functions.md",
    "api.md"
]
Depth = 2
```