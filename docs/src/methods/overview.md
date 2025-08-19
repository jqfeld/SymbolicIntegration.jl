# Integration Methods Overview

SymbolicIntegration.jl uses a flexible method dispatch system that allows you to choose different integration algorithms based on your needs.

## Available Methods

### RischMethod (Default)

The **Risch method** is the complete algorithm for symbolic integration of elementary functions, based on Manuel Bronstein's algorithms.

```julia
# Default usage
integrate(f, x)  # Automatically uses RischMethod

# Explicit usage  
integrate(f, x, RischMethod())

# With configuration
integrate(f, x, RischMethod(use_algebraic_closure=true, catch_errors=false))
```

**Capabilities:**
- ✅ Rational functions with exact arctangent terms
- ✅ Exponential and logarithmic functions  
- ✅ Trigonometric functions (via transformation)
- ✅ Complex root handling
- ✅ Integration by parts

**Best for:** Complete symbolic integration with guaranteed correctness

[→ See detailed Risch documentation](risch.md)
