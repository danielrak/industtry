# Show observations of all duplicated values of a variable or a combination of variables

Show observations of all duplicated values of a variable or a
combination of variables

## Usage

``` r
dupl_show(data_frame, vars)
```

## Arguments

- data_frame:

  Data.frame. Input data frame. Must be in the Global Environment and
  has a data.frame class

- vars:

  Character. Vector of variable or combination of variables from which
  duplicates are checked

## Value

Data.frame. The part of inputted data frame with all observations of
duplicated values of indicated variable or combination of variables

## Examples

``` r
# A fictional data with duplicated values:
df <- data.frame("person_id" = c(1, 1, 2, 3,
                                 2, 4, 5, 5 ,1),
                 "person_age" = c(25, 25, 21, 32,
                                  21, 48, 50, 50, 52),
                 "survey_month" = c("jan", "feb", "mar", "apr",
                                    "apr", "may", "jun", "jul", "jan"),
                 "survey_answer" = c("no", "yes", "no", "yes",
                                     "yes", "yes", "no", "yes", NA))

# Shuffling observations and columns to make duplicates difficult to see:
set.seed(1)
df <- df[sample(1:nrow(df)),
         sample(1:ncol(df))]
df
#>   person_id survey_month survey_answer person_age
#> 7         5          jun            no         50
#> 3         2          mar            no         21
#> 6         4          may           yes         48
#> 2         1          feb           yes         25
#> 8         5          jul           yes         50
#> 5         2          apr           yes         21
#> 1         1          jan            no         25
#> 4         3          apr           yes         32
#> 9         1          jan          <NA>         52

# See all of the rows where person_id has more than an unique possible value: 
dupl_show(data = df, var = "person_id")
#>   person_id survey_month survey_answer person_age
#> 1         1          feb           yes         25
#> 2         1          jan            no         25
#> 3         1          jan          <NA>         52
#> 4         2          mar            no         21
#> 5         2          apr           yes         21
#> 6         5          jun            no         50
#> 7         5          jul           yes         50

# See all of the rows where the combination of person_id and survey_month variables has 
# more than an unique possible value : 
dupl_show(data = df, var = c("person_id", "survey_month"))
#>   person_id survey_month survey_answer person_age
#> 1         1          jan            no         25
#> 2         1          jan          <NA>         52
```
