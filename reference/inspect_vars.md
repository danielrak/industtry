# Inspect a collection of datasets

Inspect a collection of datasets

## Usage

``` r
inspect_vars(input_path, output_path, output_label, considered_extensions)
```

## Arguments

- input_path:

  Character 1L. Folder path of datasets to explore

- output_path:

  Character 1L. Folder path where the exploration output will be stored

- output_label:

  Character 1L. Describe concisely the collection to explore

- considered_extensions:

  Character. Extensions of datasets retained for exploration in the
  input folder. Do not type the "." (dot) in it. E.g ("parquet" but not
  ".parquet")

## Value

An excel file written on the computer containing exploration information

## Examples

``` r
mydir <- file.path(tempdir(), "inspect_vars_tests_examples")
dir.create(mydir)

library(magrittr)
saveRDS(cars, file.path(mydir, "cars1.rds"))
saveRDS(mtcars, file.path(mydir, "cars2.rds"))

# Code below illustrates how to use the function:
inspect_vars(input_path = mydir, output_path = mydir,
              output_label = "cardata", 
             considered_extensions = "rds")
#> Warning: Missing `trust` will be set to FALSE by default for RDS in 2.0.0.
#> Warning: Missing `trust` will be set to FALSE by default for RDS in 2.0.0.
#> Joining by: union
#> Joining by: union

 purrr::map(1:10, \(x)
            rio::import(file.path(mydir, "inspect_vars_cardata.xlsx"),
                        sheet = x)) %>%
 magrittr::set_names(c("dims", "inspect_tot", "inspect_cars1", "inspect_cars2",
            "vars_detect", "vars_detect_everywhere", "vars_detect_not_everywhere",
            "vars_compclasses", "vars_compclasses_allsame", "vars_compclasses_not_allsame"))
#> $dims
#>   datasets nobs nvar
#> 1    cars1   50    2
#> 2    cars2   32   11
#> 
#> $inspect_tot
#>    datasets nvar nobs variables   class nb_distinct prop_distinct nb_na prop_na
#> 1     cars1    2   50     speed numeric          19          0.38     0       0
#> 2     cars1    2   50      dist numeric          35           0.7     0       0
#> 3     cars2   11   32       mpg numeric          25       0.78125     0       0
#> 4     cars2   11   32       cyl numeric           3       0.09375     0       0
#> 5     cars2   11   32      disp numeric          27       0.84375     0       0
#> 6     cars2   11   32        hp numeric          22        0.6875     0       0
#> 7     cars2   11   32      drat numeric          22        0.6875     0       0
#> 8     cars2   11   32        wt numeric          29       0.90625     0       0
#> 9     cars2   11   32      qsec numeric          30        0.9375     0       0
#> 10    cars2   11   32        vs numeric           2        0.0625     0       0
#> 11    cars2   11   32        am numeric           2        0.0625     0       0
#> 12    cars2   11   32      gear numeric           3       0.09375     0       0
#> 13    cars2   11   32      carb numeric           6        0.1875     0       0
#>    nb_void prop_void        nchars
#> 1        0         0         1 / 2
#> 2        0         0     1 / 2 / 3
#> 3        0         0         2 / 4
#> 4        0         0             1
#> 5        0         0 2 / 3 / 4 / 5
#> 6        0         0         2 / 3
#> 7        0         0     1 / 3 / 4
#> 8        0         0     3 / 4 / 5
#> 9        0         0     2 / 4 / 5
#> 10       0         0             1
#> 11       0         0             1
#> 12       0         0             1
#> 13       0         0             1
#>                                                                  modalities
#> 1                               4 / 7 / 8 / 9 / 10 / 11 / 12 / 13 / 14 / 15
#> 2                             2 / 4 / 10 / 14 / 16 / 17 / 18 / 20 / 22 / 24
#> 3         10.4 / 13.3 / 14.3 / 14.7 / 15 / 15.2 / 15.5 / 15.8 / 16.4 / 17.3
#> 4                                                                 4 / 6 / 8
#> 5        71.1 / 75.7 / 78.7 / 79 / 95.1 / 108 / 120.1 / 120.3 / 121 / 140.8
#> 6                         52 / 62 / 65 / 66 / 91 / 93 / 95 / 97 / 105 / 109
#> 7          2.76 / 2.93 / 3 / 3.07 / 3.08 / 3.15 / 3.21 / 3.23 / 3.54 / 3.62
#> 8   1.513 / 1.615 / 1.835 / 1.935 / 2.14 / 2.2 / 2.32 / 2.465 / 2.62 / 2.77
#> 9  14.5 / 14.6 / 15.41 / 15.5 / 15.84 / 16.46 / 16.7 / 16.87 / 16.9 / 17.02
#> 10                                                                    0 / 1
#> 11                                                                    0 / 1
#> 12                                                                3 / 4 / 5
#> 13                                                    1 / 2 / 3 / 4 / 6 / 8
#> 
#> $inspect_cars1
#>   1:nrow(i) variables   class nb_distinct prop_distinct nb_na prop_na nb_void
#> 1     Obs =        50    <NA>        <NA>          <NA>  <NA>    <NA>    <NA>
#> 2   Nvars =         2    <NA>        <NA>          <NA>  <NA>    <NA>    <NA>
#> 3         1     speed numeric          19          0.38     0       0       0
#> 4         2      dist numeric          35           0.7     0       0       0
#>   prop_void    nchars                                    modalities
#> 1      <NA>      <NA>                                          <NA>
#> 2      <NA>      <NA>                                          <NA>
#> 3         0     1 / 2   4 / 7 / 8 / 9 / 10 / 11 / 12 / 13 / 14 / 15
#> 4         0 1 / 2 / 3 2 / 4 / 10 / 14 / 16 / 17 / 18 / 20 / 22 / 24
#> 
#> $inspect_cars2
#>    1:nrow(i) variables   class nb_distinct prop_distinct nb_na prop_na nb_void
#> 1      Obs =        32    <NA>        <NA>          <NA>  <NA>    <NA>    <NA>
#> 2    Nvars =        11    <NA>        <NA>          <NA>  <NA>    <NA>    <NA>
#> 3          1       mpg numeric          25       0.78125     0       0       0
#> 4          2       cyl numeric           3       0.09375     0       0       0
#> 5          3      disp numeric          27       0.84375     0       0       0
#> 6          4        hp numeric          22        0.6875     0       0       0
#> 7          5      drat numeric          22        0.6875     0       0       0
#> 8          6        wt numeric          29       0.90625     0       0       0
#> 9          7      qsec numeric          30        0.9375     0       0       0
#> 10         8        vs numeric           2        0.0625     0       0       0
#> 11         9        am numeric           2        0.0625     0       0       0
#> 12        10      gear numeric           3       0.09375     0       0       0
#> 13        11      carb numeric           6        0.1875     0       0       0
#>    prop_void        nchars
#> 1       <NA>          <NA>
#> 2       <NA>          <NA>
#> 3          0         2 / 4
#> 4          0             1
#> 5          0 2 / 3 / 4 / 5
#> 6          0         2 / 3
#> 7          0     1 / 3 / 4
#> 8          0     3 / 4 / 5
#> 9          0     2 / 4 / 5
#> 10         0             1
#> 11         0             1
#> 12         0             1
#> 13         0             1
#>                                                                  modalities
#> 1                                                                      <NA>
#> 2                                                                      <NA>
#> 3         10.4 / 13.3 / 14.3 / 14.7 / 15 / 15.2 / 15.5 / 15.8 / 16.4 / 17.3
#> 4                                                                 4 / 6 / 8
#> 5        71.1 / 75.7 / 78.7 / 79 / 95.1 / 108 / 120.1 / 120.3 / 121 / 140.8
#> 6                         52 / 62 / 65 / 66 / 91 / 93 / 95 / 97 / 105 / 109
#> 7          2.76 / 2.93 / 3 / 3.07 / 3.08 / 3.15 / 3.21 / 3.23 / 3.54 / 3.62
#> 8   1.513 / 1.615 / 1.835 / 1.935 / 2.14 / 2.2 / 2.32 / 2.465 / 2.62 / 2.77
#> 9  14.5 / 14.6 / 15.41 / 15.5 / 15.84 / 16.46 / 16.7 / 16.87 / 16.9 / 17.02
#> 10                                                                    0 / 1
#> 11                                                                    0 / 1
#> 12                                                                3 / 4 / 5
#> 13                                                    1 / 2 / 3 / 4 / 6 / 8
#> 
#> $vars_detect
#>    vars_union cars1.rds cars2.rds
#> 1       speed        ok         -
#> 2        dist        ok         -
#> 3         mpg         -        ok
#> 4         cyl         -        ok
#> 5        disp         -        ok
#> 6          hp         -        ok
#> 7        drat         -        ok
#> 8          wt         -        ok
#> 9        qsec         -        ok
#> 10         vs         -        ok
#> 11         am         -        ok
#> 12       gear         -        ok
#> 13       carb         -        ok
#> 
#> $vars_detect_everywhere
#> [1] vars_union cars1.rds  cars2.rds 
#> <0 rows> (or 0-length row.names)
#> 
#> $vars_detect_not_everywhere
#>    vars_union cars1.rds cars2.rds
#> 1       speed        ok         -
#> 2        dist        ok         -
#> 3         mpg         -        ok
#> 4         cyl         -        ok
#> 5        disp         -        ok
#> 6          hp         -        ok
#> 7        drat         -        ok
#> 8          wt         -        ok
#> 9        qsec         -        ok
#> 10         vs         -        ok
#> 11         am         -        ok
#> 12       gear         -        ok
#> 13       carb         -        ok
#> 
#> $vars_compclasses
#>    vars_union cars1.rds cars2.rds
#> 1       speed   numeric         -
#> 2        dist   numeric         -
#> 3         mpg         -   numeric
#> 4         cyl         -   numeric
#> 5        disp         -   numeric
#> 6          hp         -   numeric
#> 7        drat         -   numeric
#> 8          wt         -   numeric
#> 9        qsec         -   numeric
#> 10         vs         -   numeric
#> 11         am         -   numeric
#> 12       gear         -   numeric
#> 13       carb         -   numeric
#> 
#> $vars_compclasses_allsame
#>    vars_union cars1.rds cars2.rds
#> 1       speed   numeric         -
#> 2        dist   numeric         -
#> 3         mpg         -   numeric
#> 4         cyl         -   numeric
#> 5        disp         -   numeric
#> 6          hp         -   numeric
#> 7        drat         -   numeric
#> 8          wt         -   numeric
#> 9        qsec         -   numeric
#> 10         vs         -   numeric
#> 11         am         -   numeric
#> 12       gear         -   numeric
#> 13       carb         -   numeric
#> 
#> $vars_compclasses_not_allsame
#> [1] vars_union cars1.rds  cars2.rds 
#> <0 rows> (or 0-length row.names)
#> 
            # code above illustrates all 10 sheets of the output

unlink(mydir, recursive = TRUE)
```
