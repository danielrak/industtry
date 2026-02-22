# Import a collection of datasets into the Global Environment (parallelized)

Import a collection of datasets into the Global Environment
(parallelized)

## Usage

``` r
parallel_import(file_paths)
```

## Arguments

- file_paths:

  Character. Vector of valid absolute file paths of datasets to import.
  File names must be unique.

## Value

After jobs completion, see the datasets imported in the Global
Environment

## Examples

``` r
mydir <- system.file("permadir_examples_and_tests/importations", package = "industtry")
lfiles <- list.files(mydir, full.names = TRUE)

if (isTRUE(rstudioapi::isAvailable())) {
  parallel_import(lfiles)} else {
    message("This function works only in RStudio.")
  }
#> This function works only in RStudio.
```
