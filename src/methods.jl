# Method dispatch system for SymbolicIntegration.jl

"""
    AbstractIntegrationMethod

Abstract supertype for all symbolic integration methods.
"""
abstract type AbstractIntegrationMethod end

"""
    RischMethod <: AbstractIntegrationMethod

Risch algorithm for symbolic integration of elementary functions.

# Fields
- `use_algebraic_closure::Bool`: Whether to use algebraic closure for complex roots (default: true)
- `catch_errors::Bool`: Whether to catch and handle algorithm errors gracefully (default: true)
"""
struct RischMethod <: AbstractIntegrationMethod
    use_algebraic_closure::Bool
    catch_errors::Bool
    
    function RischMethod(; use_algebraic_closure::Bool=true, catch_errors::Bool=true)
        new(use_algebraic_closure, catch_errors)
    end
end

# Method dispatch integration
function integrate(f::Symbolics.Num, x::Symbolics.Num, method::RischMethod; kwargs...)
    # Call renamed Risch function with method options
    return integrate_risch(f, x;
        useQQBar=method.use_algebraic_closure,
        catchNotImplementedError=method.catch_errors,
        catchAlgorithmFailedError=method.catch_errors,
        kwargs...)
end

# Main integrate function - dispatches to RischMethod by default
function integrate(f::Symbolics.Num, x::Symbolics.Num; kwargs...)
    return integrate_risch(f, x; kwargs...)
end

# Method traits
method_supports_rational(method::RischMethod) = true
method_supports_transcendental(method::RischMethod) = true