# Detect character structure from datasets

Detect character structure from datasets

## Usage

``` r
detect_chars_structure_datasets(
  datasets_folderpath,
  considered_extensions,
  patterns,
  output_filepath = file.path(datasets_folderpath, paste0("detect_chars_structure_",
    basename(datasets_folderpath), ".rds")),
  get_output_in_session = TRUE
)
```

## Arguments

- datasets_folderpath:

  Character 1L. Folder path of datasets to process. These datasets must
  be at the root of the path

- considered_extensions:

  Character. Datasets file extensions to consider. Extensions must be
  one supported by the rio:: package

- patterns:

  Character. Patterns to detect across the datasets variables. Regex is
  supported

- output_filepath:

  Character 1L. Output folder path.

- get_output_in_session:

  Logical 1L. If TRUE, the function return a list, such that each
  element element corresponds to pattern detection details for each
  considered dataset

## Examples

``` r
mydir <- system.file("detect_chars_structure_datasets", package = "industtry")

detect <- detect_chars_structure_datasets(
  datasets_folderpath = mydir, 
  considered_extensions = "xlsx", 
  patterns = "(?i)college", 
  output_filepath = file.path(mydir, "detect_college.rds"), 
  get_output_in_session = TRUE)

# head(lapply(detect, head))

file.exists(file.path(mydir, "detect_college.rds"))
#> [1] TRUE
```
