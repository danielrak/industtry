# Variable class comparison - all of same type across all datasets

Variable class comparison - all of same type across all datasets

## Usage

``` r
vars_compclasses_allsame(vars_compclasses_table)
```

## Arguments

- vars_compclasses_table:

  Output of the vars_compclasses() function in this package.

## Value

From vars_compclasses_table, extract type-consistent variables through
all the datasets.

## Examples

``` r
library(magrittr)
vcompclasses_table <- vars_compclasses(c("cars", "mtcars"))
vars_compclasses_allsame(vcompclasses_table)
#>    vars_union    cars  mtcars
#> 1       speed numeric       -
#> 2        dist numeric       -
#> 3         mpg       - numeric
#> 4         cyl       - numeric
#> 5        disp       - numeric
#> 6          hp       - numeric
#> 7        drat       - numeric
#> 8          wt       - numeric
#> 9        qsec       - numeric
#> 10         vs       - numeric
#> 11         am       - numeric
#> 12       gear       - numeric
#> 13       carb       - numeric
library(magrittr)
data(cars)
data(mtcars)
vcompclasses <- vars_compclasses(c("cars", "mtcars"))
vars_compclasses_allsame(vcompclasses)
#>    vars_union    cars  mtcars
#> 1       speed numeric       -
#> 2        dist numeric       -
#> 3         mpg       - numeric
#> 4         cyl       - numeric
#> 5        disp       - numeric
#> 6          hp       - numeric
#> 7        drat       - numeric
#> 8          wt       - numeric
#> 9        qsec       - numeric
#> 10         vs       - numeric
#> 11         am       - numeric
#> 12       gear       - numeric
#> 13       carb       - numeric
```
