# Generalized characters structure

Get any user-defined patterns from each symbol of character vector

## Usage

``` r
chars_structure_general(
  input_vector,
  split = "",
  patterns_and_replacements,
  unique = TRUE,
  named_output = TRUE
)
```

## Arguments

- input_vector:

  Character. Vector to process

- split:

  Character 1L. Symbol separator

- patterns_and_replacements:

  Character. Named character vector of patterns (names) and replacements
  (values)

- unique:

  Logical 1L. If TRUE, the result is reduced to unique values

- named_output:

  Logical 1L. If TRUE, output vector is named after corresponding input
  values.

## Value

Character. Vector describing structure of each element of input_vector,
see example.

## Examples

``` r
input <- c("ABC123", "DE4F56", "789GHI", "ABC123")

# Default values of unique and named_output:
chars_structure_general(input_vector = input, split = "", 
                        patterns_and_replacements = c("[:alpha:]" = "[letter]", 
                                                      "[:digit:]" = "[number]"), 
                        unique = TRUE, named_output = TRUE)
#>                                       ABC123 
#>                       "3[letter], 3[number]" 
#>                                       DE4F56 
#> "2[letter], 1[number], 1[letter], 2[number]" 
#>                                       789GHI 
#>                       "3[number], 3[letter]" 

# unique is set to default value TRUE and named_output is set to FALSE:
chars_structure_general(input_vector = input, split = "", 
                        patterns_and_replacements = c("[:alpha:]" = "[letter]", 
                                                      "[:digit:]" = "[number]"), 
                        unique = TRUE, named_output = FALSE)
#> [1] "3[letter], 3[number]"                      
#> [2] "2[letter], 1[number], 1[letter], 2[number]"
#> [3] "3[number], 3[letter]"                      

# unique is set to FALSE and named_output to FALSE:
chars_structure_general(input_vector = input, split = "", 
                        patterns_and_replacements = c("[:alpha:]" = "[letter]", 
                                                      "[:digit:]" = "[number]"), 
                        unique = FALSE, named_output = FALSE)
#> [1] "3[letter], 3[number]"                      
#> [2] "2[letter], 1[number], 1[letter], 2[number]"
#> [3] "3[number], 3[letter]"                      
#> [4] "3[letter], 3[number]"                      

# unique is set to FALSE and named_output to defalut value TRUE:
chars_structure_general(input_vector = input, split = "", 
                        patterns_and_replacements = c("[:alpha:]" = "[letter]", 
                                                      "[:digit:]" = "[number]"), 
                        unique = FALSE, named_output = TRUE)
#>                                       ABC123 
#>                       "3[letter], 3[number]" 
#>                                       DE4F56 
#> "2[letter], 1[number], 1[letter], 2[number]" 
#>                                       789GHI 
#>                       "3[number], 3[letter]" 
#>                                       ABC123 
#>                       "3[letter], 3[number]" 
```
