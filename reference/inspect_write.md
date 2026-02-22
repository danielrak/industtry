# Inspect a data frame and write the output in an excel file

Inspect a data frame and write the output in an excel file

## Usage

``` r
inspect_write(data_frame_name, output_path, output_label = NULL)
```

## Arguments

- data_frame_name:

  Character 1L. The data.frame to explore. Must exist in the Global
  Environment

- output_path:

  Character 1L. Folder path where to write the excel output

- output_label:

  Character 1L. Optional 1-length character vector to label output file.
  If NULL, data_frame_name will also used as label

## Value

See output xlsx file. Variable list of the dataset and systematic
informations for each variable

## Examples

``` r
library(magrittr)
data(cars)
mydir <- file.path(tempdir(), "inspect_variants_tests_examples")
dir.create(mydir)
inspect_write(data_frame_name = "cars", 
              output_path = mydir, 
              output_label = "cars")
readxl::read_xlsx(file.path(mydir, "inspect_cars.xlsx"))
#> # A tibble: 4 × 11
#>   `1:nrow(i)` variables class   nb_distinct prop_distinct nb_na prop_na nb_void
#>   <chr>       <chr>     <chr>   <chr>       <chr>         <chr> <chr>   <chr>  
#> 1 Obs =       50        NA      NA          NA            NA    NA      NA     
#> 2 Nvars =     2         NA      NA          NA            NA    NA      NA     
#> 3 1           speed     numeric 19          0.38          0     0       0      
#> 4 2           dist      numeric 35          0.7           0     0       0      
#> # ℹ 3 more variables: prop_void <chr>, nchars <chr>, modalities <chr>
unlink(mydir, recursive = TRUE)
```
