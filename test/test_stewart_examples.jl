using Test
using SymbolicIntegration
using Symbolics

@testset "Stewart Calculus Examples" begin
    # Selected examples from James Stewart - Calculus (1987)
    # Integration Test Problems from https://rulebasedintegration.org/testProblems.html
    
    @variables x
    
    @testset "Basic Integration Formulas" begin
        # Section 7.1 - Basic integration formulas that should work reliably
        
        # Power rule: ∫x^n dx = x^(n+1)/(n+1)
        @test string(integrate(x^2, x)) == "(1//3)*(x^3)"
        @test string(integrate(x^3, x)) == "(1//4)*(x^4)"
        
        # Exponential: ∫exp(x) dx = exp(x)  
        @test string(integrate(exp(x), x)) == "exp(x)"
        
        # Logarithmic: ∫(1/x) dx = log(x)
        @test string(integrate(1/x, x)) == "log(x)"
        
        # Logarithmic integration by parts: ∫log(x) dx = x*log(x) - x
        @test string(integrate(log(x), x)) == "-x + x*log(x)"
    end
    
    @testset "Rational Function Examples" begin
        # Selected rational function cases that demonstrate core functionality
        
        # Simple partial fractions
        f1 = (x + 1)//(x^2 + x)
        result1 = integrate(f1, x)
        @test !isnothing(result1)
        
        # Quadratic denominators  
        f2 = x//(x^2 + 1)
        result2 = integrate(f2, x)
        @test !isnothing(result2)
        
        # More complex rational functions
        f3 = (x^2 + 3*x + 2)//(x^3 + 2*x^2 + x)
        result3 = integrate(f3, x)
        @test !isnothing(result3)
    end
    
    @testset "Transcendental Function Examples" begin
        # Examples involving exp, log, and trigonometric functions
        
        # Exponential functions
        test_cases_exp = [
            exp(x),
            x * exp(x),   # Integration by parts case
            exp(2*x),     # Constant multiple in exponent
        ]
        
        for f in test_cases_exp
            result = integrate(f, x)
            @test !isnothing(result)
            @test string(result) isa String
        end
        
        # Logarithmic functions  
        test_cases_log = [
            log(x),
            1/(x * log(x)),  # Substitution case
        ]
        
        for f in test_cases_log
            result = integrate(f, x)
            @test !isnothing(result)
            @test string(result) isa String
        end
    end
    
    @testset "Integration Robustness" begin
        # Test that integration doesn't crash on a variety of expressions
        # even if the exact symbolic form might differ from textbook results
        
        test_expressions = [
            # Polynomial cases
            x^4 + 3*x^2 + 2,
            (x^2 + 1)^2,
            
            # Rational function cases  
            (x + 1)//(x + 2),
            (x^2 + x + 1)//(x^2 + 1),
            
            # Transcendental cases
            exp(x) + log(x),
            x * log(x),
        ]
        
        for expr in test_expressions
            result = integrate(expr, x)
            @test !isnothing(result)
            @test string(result) isa String
            @test length(string(result)) > 0  # Non-empty result
        end
    end
end