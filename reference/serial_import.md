# Import a collection of datasets into the Global Environment (serialized)

Import a collection of datasets into the Global Environment (serialized)

## Usage

``` r
serial_import(file_paths)
```

## Arguments

- file_paths:

  Character. Vector of valid absolute file paths of datasets to import

## Value

After completion, see the datasets imported in the Global Environment

## Examples

``` r
library(magrittr)
mydir <- system.file("permadir_examples_and_tests/importations", package = "industtry")
lfiles <- list.files(mydir, full.names = TRUE) %>% 
  (\(x) x[stringr::str_detect(x, "\\.rds$")])

# Launch this code and check your global env, 
# cars.rds and mtcars.rds should be there: 
serial_import(lfiles)
#> Warning: Missing `trust` will be set to FALSE by default for RDS in 2.0.0.
#> Warning: Missing `trust` will be set to FALSE by default for RDS in 2.0.0.
#> [[1]]
#> NULL
#> 
#> [[2]]
#> NULL
#> 
```
