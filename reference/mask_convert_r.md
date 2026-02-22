# Create an excel mask compatible with the convert_r() function

Create an excel mask compatible with the convert_r() function

## Usage

``` r
mask_convert_r(output_path, output_filename = "mask_convert_r.xlsx")
```

## Arguments

- output_path:

  Character 1L. Folder path where the mask will be created

- output_filename:

  Character 1L. File name (with extension) of the mask

## Examples

``` r
mydir <- file.path(tempdir(), "convert_r_tests_examples")
dir.create(mydir)

mask_convert_r(output_path = mydir)

list.files(mydir)
#> [1] "mask_convert_r.xlsx"

unlink(mydir, recursive = TRUE)
```
