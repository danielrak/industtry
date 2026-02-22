# Collection-level variables types comparison

Collection-level variables types comparison

## Usage

``` r
vars_compclasses(data_frames)
```

## Arguments

- data_frames:

  Character. The datasets to explore. Need to exist in the Global
  Environment

## Value

Variable list and their respective types across all inputted datasets.

## Examples

``` r
library(magrittr)
data(cars)
data(mtcars)
vars_compclasses(c("cars", "mtcars"))
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
