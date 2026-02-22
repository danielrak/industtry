# Detect character structure Detect if values within a character variable match at least one of defined patterns

Detect character structure Detect if values within a character variable
match at least one of defined patterns

## Usage

``` r
detect_chars_structure(vector, patterns, verbose = FALSE)
```

## Arguments

- vector:

  Character. Input vector to detect pattern from

- patterns:

  Character. Patterns to detect within vector. Regex is supported

- verbose:

  Logical 1L. If TRUE, additional details related to the pattern
  detection are provided

## Value

Logical 1L. If verbose is set to TRUE, the function returns a list with
the following elements in order:

- "Any defined structure" : Logical 1L. TRUE if the pattern is detected
  anywhere from the input vector

- "Which" : Character. Unique values of input vector matching the
  defined patterns

- "Where" : Integer. Indexes of values from input vector matching the
  defined patterns

## Examples

``` r
detect_chars_structure(
  vector = c("ABCD1234", "4567EF", "89GHIJ10"), 
  patterns = "[:alpha:]{4}" # detect four consecutive alphabetic values
)
#> [1] TRUE

detect_chars_structure(
  vector = c("ABCD1234", "4567EF", "89GHIJ10"), 
  patterns = "[:alpha:]{4}", 
  verbose = TRUE
)
#> $`Any defined structure`
#> [1] TRUE
#> 
#> $Which
#> [1] "ABCD1234" "89GHIJ10"
#> 
#> $Where
#> [1] 1 3
#> 
```
