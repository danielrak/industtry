# Industrialized dataset formats conversion (RStudio only)

Industrialized dataset formats conversion (RStudio only)

## Usage

``` r
convert_r(mask_filepath, output_path)
```

## Arguments

- mask_filepath:

  Character 1L. Entire file path of the excel mask

- output_path:

  Character 1L. Folder path where the converted datasets will be placed

## Examples

``` r
library(magrittr)

mydir <- system.file("permadir_examples_and_tests/convert_r", package = "industtry")

# Datasets to convert (one-shot):
# rio::export(cars, file.path(mydir, "original_cars.rds"))
# rio::export(mtcars, file.path(mydir, "original_mtcars.csv"))

# Create an artificial compatible mask with R:
mask <- data.frame(
  "folder_path" = rep(mydir, 2),
  "file" = c("original_cars.rds", "original_mtcars.csv"),
  "converted_file" = c("converted_cars.parquet", "converted_mtcars.parquet"),
  "to_convert" = rep(1, 2)
)
writexl::write_xlsx(mask, file.path(mydir, "mask_convert_r.xlsx"))

if (rstudioapi::isAvailable()) {
  convert_r(
    mask_filepath = file.path(mydir, "mask_convert_r.xlsx"),
    output_path = mydir)} else {
      message("You're not in RStudio. This example will not run.")
    }
#> You're not in RStudio. This example will not run.

# See original and converted files:
list.files(mydir) %>% purrr::keep(stringr::str_detect(., "cars"))
#> [1] "original_cars.rds"   "original_mtcars.csv"

# Remove converted files for tests integrity:
file.remove(file.path(
  mydir,
  c("converted_cars.parquet", "converted_mtcars.parquet")))
#> Warning: cannot remove file '/home/runner/work/_temp/Library/industtry/permadir_examples_and_tests/convert_r/converted_cars.parquet', reason 'No such file or directory'
#> Warning: cannot remove file '/home/runner/work/_temp/Library/industtry/permadir_examples_and_tests/convert_r/converted_mtcars.parquet', reason 'No such file or directory'
#> [1] FALSE FALSE
```
