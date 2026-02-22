# Replace character vector values using a correspondence approach

Replace character vector values using a correspondence approach

## Usage

``` r
replace_multiple(input_vector, replacements, replace_all = FALSE)
```

## Arguments

- input_vector:

  Character. Character vector on which replacements take place

- replacements:

  Character. Named character vector: replacement correspondences

- replace_all:

  Logical. If TRUE, stringr::str_replace_all() is used instead of
  stringr::str_replace()

## Examples

``` r
input <- c("one-one", "two-two-one", "three-three-two")

replace_multiple(input,
                 replacements =
                   c("one" = "1", "two" = "2",
                     "three" = "3"))
#> [1] "1-one"       "2-two-one"   "3-three-two"

replace_multiple(input,
                 replacements =
                   c("one" = "1", "two" = "2",
                     "three" = "3"),
                 replace_all = TRUE)
#> [1] "1-1"     "2-2-one" "3-3-two"
```
