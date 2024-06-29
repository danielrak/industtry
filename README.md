
<!-- README.md is generated from README.Rmd. Please edit that file -->

``` r
library(magrittr)
```

# The industtry package - a toolkit for structured datasets exploitation

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/danielrak/industtry/branch/master/graph/badge.svg)](https://app.codecov.io/gh/danielrak/industtry?branch=master)
[![R-CMD-check](https://github.com/danielrak/industtry/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danielrak/industtry/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This package proposes a set of functions that helps exploiting
structured datasets (mostly data frames) with an industrialization
approach. Industrialization here means applying as efficiently as
possible the same procedure to any number of inputs as long as these
inputs have an identified common structure. This idea would have been
very difficult to implement without the `purrr::` and `rio::` packages:

``` r
purrr:::map(c("purrr", "rio"), citation) %>% print(style = "text")
#> [[1]]
#> Wickham H, Henry L (2023). _purrr: Functional Programming Tools_. R
#> package version 1.0.2, <https://CRAN.R-project.org/package=purrr>.
#> 
#> [[2]]
#> Chan C, Leeper T, Becker J, Schoch D (2023). _rio: A Swiss-army knife
#> for data file I/O_. <https://cran.r-project.org/package=rio>.
```

**It’s best to use it with RStudio.**

Its contribution is probably in the idea of applying transformations to
the set level (of any number of data frames, for e.g), given that
numerous existing package help the user exploit one dataset at a time.
The functions of this package that are the most in line with this
philosophy are: `convert_r()`, `inspect_vars()`, `serial_import()` and
`parallel_import()`.

This package also provides a set of micro-tools for dealing with usual
data transformation tasks, particularly with R/RStudio.

## Installation

You can install the development version of industtry from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("danielrak/industtry")
```

## Example 1 - importations

``` r
library(industtry)
```

Most (but not all) use cases of data exploitation begins with datasets
importation. When you have to work in some way with several datasets
simultaneously, it may be useful to be able to import these with a
simple code. That is the purpose of the two functions: `serial_import()`
and `parallel_import()`.

``` r
# You begin with an empty working session: 
ls()
#> character(0)
```

``` r
# Say you want to import two data frames : cars.rds and mtcars.rds stored somewhere accessible to you: 
yourdir <- system.file("permadir_examples_and_tests/importations", package = "industtry")

list.files(yourdir) %>% purrr::keep(stringr::str_detect(., "\\.rds$"))
#> [1] "cars.rds"   "mtcars.rds"
```

``` r

# Note that as long as you have the resources (storage and memory), the procedure is the same for 2, 20, 200, ... data frames. 
```

``` r
# Prepare a list of paths of data frames you want to import: 
lfiles <- list.files(yourdir, full.names = TRUE) %>% 
  purrr::keep(stringr::str_detect(., "\\.rds"))
```

``` r
# One by one importation:
serial_import(lfiles)
#> [[1]]
#> NULL
#> 
#> [[2]]
#> NULL
```

``` r

ls()
#> [1] "cars.rds"   "lfiles"     "mtcars.rds" "yourdir"
```

``` r
# You should have correctly imported the data: 
list(head(cars.rds), head(mtcars.rds))
#> [[1]]
#>   speed dist
#> 1     4    2
#> 2     4   10
#> 3     7    4
#> 4     7   22
#> 5     8   16
#> 6     9   10
#> 
#> [[2]]
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

``` r
# Remove from working session to illustrate parallel_import(): 
rm(cars.rds, mtcars.rds)
```

``` r
# If you want to be able to still use the Console while importing or to avoid interrupting all of the process after one failure: 
parallel_import(lfiles)
```

``` r
# This is what you should observe: 
imagedir <- system.file("images", package = "industtry")

knitr::include_graphics(file.path(imagedir, "parallel_import_jobs.png"))
```

<img src="C:/Users/rheri/AppData/Local/R/win-library/4.3/industtry/images/parallel_import_jobs.png" width="100%" />
