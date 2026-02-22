# Get :alpha: / :digit: patterns from each symbol of character vector

Get :alpha: / :digit: patterns from each symbol of character vector

## Usage

``` r
chars_structure(input_vector, unique = TRUE, named_output = TRUE)
```

## Arguments

- input_vector:

  Character. Vector to process

- unique:

  Logical 1L. If TRUE, the result is reduced to unique values.

- named_output:

  Logical 1L. If TRUE, output vector is named after corresponding input
  values.

## Value

Character. Vector describing structure of each element of input_vector,
see example.

## Examples

``` r
library(magrittr)
input <- c("ABC123", "DE4F56", "789GHI", "ABC123")

# Default values of unique and named_output: 
chars_structure(input_vector = input, unique = TRUE, named_output = TRUE)
#>           ABC123           DE4F56           789GHI 
#>         "3A, 3D" "2A, 1D, 1A, 2D"         "3D, 3A" 

# unique is set to default value TRUE and named_output is set to FALSE: 
chars_structure(input_vector = input, unique = TRUE, named_output = FALSE)
#> [1] "3A, 3D"         "2A, 1D, 1A, 2D" "3D, 3A"        

# unique is set to FALSE and named_output to FALSE: 
chars_structure(input_vector = input, unique = FALSE, named_output = FALSE)
#> [1] "3A, 3D"         "2A, 1D, 1A, 2D" "3D, 3A"         "3A, 3D"        

# unique is set to FALSE and named_output to defalut value TRUE: 
chars_structure(input_vector = input, unique = FALSE, named_output = TRUE)
#>           ABC123           DE4F56           789GHI           ABC123 
#>         "3A, 3D" "2A, 1D, 1A, 2D"         "3D, 3A"         "3A, 3D" 
```
