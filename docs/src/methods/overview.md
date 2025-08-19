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

## Future Methods

The method dispatch system is designed to support additional integration algorithms:

### Planned Methods

#### HeuristicMethod (Future)
Fast pattern-matching based integration for common cases.
```julia
integrate(f, x, HeuristicMethod())  # Fast heuristic patterns
```

#### NumericalMethod (Future)  
Numerical integration with symbolic preprocessing.
```julia
integrate(f, x, NumericalMethod(tolerance=1e-10))  # Numerical fallback
```

#### SymPyMethod (Future)
Integration using SymPy backend for comparison.
```julia
integrate(f, x, SymPyMethod())  # SymPy compatibility
```

## Method Selection Guide

### Choosing the Right Method

| Use Case | Recommended Method | Reason |
|----------|-------------------|---------|
| **Exact symbolic results** | `RischMethod()` | Complete, guaranteed correct |
| **Research/verification** | `RischMethod(catch_errors=false)` | Strict algorithmic behavior |
| **Production applications** | `RischMethod(catch_errors=true)` | Robust error handling |
| **Complex analysis** | `RischMethod(use_algebraic_closure=true)` | Full arctangent terms |
| **Simple computations** | `RischMethod(use_algebraic_closure=false)` | Faster execution |

### Method Comparison

| Method | Speed | Completeness | Robustness | Use Case |
|--------|-------|--------------|------------|----------|
| **RischMethod** | Moderate | Complete | High | Research, exact results |
| **HeuristicMethod** (future) | Fast | Partial | Moderate | Common patterns |
| **NumericalMethod** (future) | Variable | Approximate | High | Fallback cases |

## Method Architecture

### Abstract Type Hierarchy
```julia
AbstractIntegrationMethod
├── RischMethod                     # Complete symbolic integration
├── AbstractRationalIntegration     # Rational function specialists  
└── AbstractTranscendentalIntegration # Transcendental specialists
```

### Method Interface
```julia
# General interface
integrate(f, x, method::AbstractIntegrationMethod; kwargs...)

# Method-specific traits
method_supports_rational(method)      # Check rational function support
method_supports_transcendental(method) # Check transcendental support
```

## Configuration Patterns

### Common Configurations

```julia
# Research configuration (strict, complete)
research_config = RischMethod(
    use_algebraic_closure=true,
    catch_errors=false
)

# Production configuration (robust, complete)
production_config = RischMethod(
    use_algebraic_closure=true, 
    catch_errors=true
)

# Performance configuration (fast, simple)
performance_config = RischMethod(
    use_algebraic_closure=false,
    catch_errors=true
)
```

### Method Workflows

```julia
@variables x f

# Try different methods in sequence
function robust_integrate(f, x)
    try
        # First try exact Risch method
        return integrate(f, x, RischMethod(catch_errors=false))
    catch NotImplementedError
        # Fall back to heuristic method (future)
        return integrate(f, x, HeuristicMethod())
    catch AlgorithmFailedError
        # Fall back to numerical method (future)  
        return integrate(f, x, NumericalMethod())
    end
end
```

## Extending with New Methods

The method system is designed for easy extension:

### Adding a New Method

1. **Define method type**:
```julia
struct MyMethod <: AbstractIntegrationMethod
    option1::Bool
    option2::Float64
end
```

2. **Implement integration**:
```julia
function SymbolicIntegration._integrate(f, x, method::MyMethod; kwargs...)
    # Your algorithm implementation
    return result
end
```

3. **Add method traits**:
```julia
method_supports_rational(method::MyMethod) = true
method_supports_transcendental(method::MyMethod) = false
```

### Plugin Architecture

The dispatch system supports:
- **Third-party packages**: Can add new methods
- **Method composition**: Combining different approaches  
- **Fallback chains**: Trying multiple methods in sequence
- **Performance optimization**: Method-specific tuning

## Performance and Benchmarking

### Method Performance Characteristics

- **RischMethod**: Exact results, moderate speed, complete coverage
- **Future methods**: Will provide different speed/accuracy tradeoffs

### Benchmarking Methods

```julia
using BenchmarkTools

@variables x
f = (x^3 + x^2 + x + 2)/(x^4 + 3*x^2 + 2)

# Benchmark different configurations
@benchmark integrate($f, $x, RischMethod(use_algebraic_closure=true))
@benchmark integrate($f, $x, RischMethod(use_algebraic_closure=false))
```

## Migration and Compatibility

### Current Usage Patterns

All existing code continues to work:
```julia
# Existing code (still works)
integrate(f, x)

# New explicit method (equivalent)
integrate(f, x, RischMethod())
```

The method system provides a **migration path** for users to gradually adopt new integration methods as they become available, while maintaining full compatibility with existing workflows.