# API Reference

```@meta
CurrentModule = SymbolicIntegration
```

## Main Functions

```@docs
integrate
```

## Algorithm Overview

SymbolicIntegration.jl implements the complete symbolic integration algorithms from Manuel Bronstein's book "Symbolic Integration I: Transcendental Functions".

### Supported Function Classes

- **Polynomial functions**: ∫xⁿ dx
- **Rational functions**: ∫P(x)/Q(x) dx using Rothstein-Trager method
- **Exponential functions**: ∫exp(f(x)) dx using Risch algorithm
- **Logarithmic functions**: ∫log(f(x)) dx using integration by parts
- **Trigonometric functions**: Transformed to exponential form

### Algorithm Components

The package includes implementations of:
- Hermite reduction for rational functions
- Rothstein-Trager method for logarithmic parts
- Risch algorithm for transcendental functions
- Differential field tower construction
- Complex root finding for arctangent terms

## Internal Structure

The package is organized into several algorithm modules:
- `rational_functions.jl`: Rational function integration algorithms
- `transcendental_functions.jl`: Risch algorithm implementation  
- `differential_fields.jl`: Differential field operations
- `complex_fields.jl`: Complex number field handling
- `frontend.jl`: User interface and expression conversion

## Error Handling

The package defines custom exception types:
- `NotImplementedError`: For unsupported function types
- `AlgorithmFailedError`: When no elementary antiderivative exists
- `AlgebraicNumbersInvolved`: When algebraic numbers complicate the result

## Index

```@index
```