# Inspect a data frame

Inspect a data frame

## Usage

``` r
inspect(data_frame, nrow = FALSE)
```

## Arguments

- data_frame:

  Data.frame. The data.frame to explore. Need to exist in the Global
  Environment.

- nrow:

  Logical 1L. If TRUE, the number of observations of the dataset is
  rendered in addition.

## Value

Variable list of the dataset and systematic informations for each
variable.

## Examples

``` r
library(magrittr)
inspect(CO2)
#> # A tibble: 6 × 10
#>   variables class   nb_distinct prop_distinct nb_na prop_na nb_void prop_void
#>   <chr>     <chr>         <int>         <dbl> <int>   <dbl>   <int>     <dbl>
#> 1 Plant     ordered          12        0.143      0       0       0         0
#> 2 Plant     factor           12        0.143      0       0       0         0
#> 3 Type      factor            2        0.0238     0       0       0         0
#> 4 Treatment factor            2        0.0238     0       0       0         0
#> 5 conc      numeric           7        0.0833     0       0       0         0
#> 6 uptake    numeric          76        0.905      0       0       0         0
#> # ℹ 2 more variables: nchars <chr>, modalities <chr>
```
