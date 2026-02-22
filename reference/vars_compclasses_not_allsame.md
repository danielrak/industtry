# Variable class comparison - not all of same type across all datasets

Variable class comparison - not all of same type across all datasets

## Usage

``` r
vars_compclasses_not_allsame(vars_compclasses_table)
```

## Arguments

- vars_compclasses_table:

  Output of the vars_compclasses() function in this package.

## Value

From vars_compclasses_table, extract type-inconsistent variables through
all the datasets.

## Examples

``` r
library(magrittr)
vcompclasses_table <- vars_compclasses(c("cars", "mtcars"))
vars_compclasses_not_allsame(vcompclasses_table)
#> [1] vars_union cars       mtcars    
#> <0 rows> (or 0-length row.names)
library(magrittr)
data(cars)
data(mtcars)
vcompclasses <- vars_compclasses(c("cars", "mtcars"))
vars_compclasses_not_allsame(vcompclasses)
#> [1] vars_union cars       mtcars    
#> <0 rows> (or 0-length row.names)
```
