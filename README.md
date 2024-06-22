
<!-- README.md is generated from README.Rmd. Please edit that file -->

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
inputs have an identified common structure.

**It’s best to use it with RStudio.**

Its contribution is probably in the idea of applying transformations to
the set level (of any number of data frames, for e.g), given that
numerous existing package hepls the user exploit one dataset at a time.
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
