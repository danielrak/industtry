# Variable detection - inconsistent patterns

Variable detection - inconsistent patterns

## Usage

``` r
vars_detect_not_everywhere(vars_detect_table)
```

## Arguments

- vars_detect_table:

  Output of the vars_detect() function in this package. This object must
  exists into the Global Environment.

## Value

From vars_detect_table, extract variables that are not always present
through all the datasets.

## Examples

``` r
library(magrittr)
data(cars)
data(mtcars)
vdetect_table <- vars_detect(c("cars", "mtcars"))
#> Joining by: union
#> Joining by: union
vars_detect_not_everywhere(vdetect_table)
#>    vars_union cars mtcars
#> 1       speed   ok      -
#> 2        dist   ok      -
#> 3         mpg    -     ok
#> 4         cyl    -     ok
#> 5        disp    -     ok
#> 6          hp    -     ok
#> 7        drat    -     ok
#> 8          wt    -     ok
#> 9        qsec    -     ok
#> 10         vs    -     ok
#> 11         am    -     ok
#> 12       gear    -     ok
#> 13       carb    -     ok
```
