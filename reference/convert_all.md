# Convert all datasets within a folder to a given file format

Convert all datasets within a folder to a given file format

## Usage

``` r
convert_all(
  input_folderpath,
  considered_extensions,
  to,
  output_folderpath = input_folderpath
)
```

## Arguments

- input_folderpath:

  Character 1L. Folder path containing datasets to convert. Datasets
  must be at the root of the folder

- considered_extensions:

  Character. File extensions to consider for conversion within the
  folder. Must be supported by the rio:: package

- to:

  Character 1L. The destination output format. Must be supported by the
  rio:: package

- output_folderpath:

  Character 1L. Folder path where converted file should be placed

## Value

This function, for RStudio only, launches one background job for each
file to convert

## Examples

``` r
mydir <- system.file("permadir_examples_and_tests/convert_all", package = "industtry") 

list.files(mydir)
#> [1] "original_cars.rds"   "original_mtcars.csv"

if (rstudioapi::isAvailable()) {
convert_all(input_folderpath = mydir, considered_extensions = c("rds", "csv"), 
            to = "parquet", output_folderpath = mydir)

list.files(mydir)

unlink(file.path(mydir, c("original_cars.parquet", "original_mtcars.parquet")))
}
```
