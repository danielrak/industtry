# Create an excel mask compatible with the rename_r() function.

Create an excel mask compatible with the rename_r() function. This must
be used on a collection of files, i.e stored within the same folder.

## Usage

``` r
mask_rename_r(input_path, output_filename = "mask_rename_r.xlsx")
```

## Arguments

- input_path:

  Character 1L. Folder containing the set of files to rename

- output_filename:

  Character 1L. File name of the excel mask.

## Value

See the created excel mask in the indicated input_path

## Examples

``` r
library(magrittr)
data(cars)
data(mtcars)

mydir <- tempfile()
dir.create(mydir)

saveRDS(cars, file.path(mydir, "cars.rds"))
saveRDS(mtcars, file.path(mydir, "mtcars.rds"))

list.files(mydir)
#> [1] "cars.rds"   "mtcars.rds"

mask_rename_r(input_path = mydir)

list.files(mydir)
#> [1] "cars.rds"           "mask_rename_r.xlsx" "mtcars.rds"        

readxl::read_xlsx(file.path(mydir, "mask_rename_r.xlsx"))
#> # A tibble: 2 × 3
#>   file       renamed_file to_rename
#>   <chr>      <lgl>        <lgl>    
#> 1 cars.rds   NA           NA       
#> 2 mtcars.rds NA           NA       

unlink(mydir, recursive = TRUE)
```
