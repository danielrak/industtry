# Variable detection patterns

Variable detection patterns

## Usage

``` r
vars_detect(data_frames)
```

## Arguments

- data_frames:

  Character. The datasets to explore. Need to exist in the Global
  Environment

## Value

Variable list and indicators of presences/absences across all inputted
datasets.

## Examples

``` r
library(magrittr)
data(cars)
data(mtcars)
vars_detect(c("cars", "mtcars"))
#> Joining by: union
#> Joining by: union
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
