# Variable detection - presence across all the datasets

Variable detection - presence across all the datasets

## Usage

``` r
vars_detect_everywhere(vars_detect_table)
```

## Arguments

- vars_detect_table:

  Output of the vars_detect() function in this package. This object must
  exists into the Global Environment.

## Value

From vars_detect_table, extract variables that are always present
through all the datasets.

## Examples

``` r
library(magrittr)
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
data(cars)
data(mtcars)
vdetect_table <- vars_detect(c("cars", "mtcars"))
#> Joining by: union
#> Joining by: union
vars_detect_everywhere(vdetect_table)
#> [1] vars_union cars       mtcars    
#> <0 rows> (or 0-length row.names)
```
