# Industrialized file renaming

Industrialized file renaming

## Usage

``` r
rename_r(mask_filepath)
```

## Arguments

- mask_filepath:

  Character 1L. Entire file path of the excel mask

## Value

See file renamed within the mask folder

## Examples

``` r
library(magrittr)
data(cars)
data(mtcars)

mydir <- tempfile()
dir.create(mydir)

# Two example files to rename: 
saveRDS(cars, file.path(mydir, "cars.rds"))
saveRDS(mtcars, file.path(mydir, "mtcars.rds"))
list.files(mydir)
#> [1] "cars.rds"   "mtcars.rds"

# Create the mask: 
mask_rename_r(input_path = mydir)

# Fill the mask (in practice you can do it manually): 
mask <- rio::import(file.path(mydir, "mask_rename_r.xlsx"))
mask[["renamed_file"]] <- c("cars_renamed.rds", "mtcars_renamed.rds")
mask[["to_rename"]] <- rep(1, 2)
writexl::write_xlsx(mask, file.path(mydir, "mask_rename_r.xlsx"))

# Apply the rename function: 
rename_r(mask_filepath = file.path(mydir, "mask_rename_r.xlsx"))
#> $cars.rds
#> [1] TRUE
#> 
#> $mtcars.rds
#> [1] TRUE
#> 

# See the renamed files: 
list.files(mydir)
#> [1] "cars_renamed.rds"   "mask_rename_r.xlsx" "mtcars_renamed.rds"

# Clean tempdir: 
unlink(mydir, recursive = TRUE)
```
