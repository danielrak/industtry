# Illustrate sources of all duplicated values of a variable or a combination of variables

Illustrate sources of all duplicated values of a variable or a
combination of variables

## Usage

``` r
dupl_sources(data_frame, vars, output_as_df = FALSE)
```

## Arguments

- data_frame:

  Data.frame. Input data frame. Must be in the Global Environment and
  has a data.frame class

- vars:

  Character. Vector of variable or combination of variables from which
  duplicates are checked

- output_as_df:

  Logical 1L. If TRUE, output is rendered as a data.frame.

## Value

List or data.frame. For each duplicated row regarding to vars, different
values of the same variable are shown, separated by AND

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

dupl_sources(data_frame = df, vars = "person_id")
#> $`Duplicate sources where person_id equals 1`
#>                      values
#> person_id                 1
#> survey_month  feb [AND] jan
#> survey_answer  yes [AND] no
#> person_age      25 [AND] 52
#> 
#> $`Duplicate sources where person_id equals 2`
#>                      values
#> person_id                 2
#> survey_month  mar [AND] apr
#> survey_answer  no [AND] yes
#> 
#> $`Duplicate sources where person_id equals 5`
#>                      values
#> person_id                 5
#> survey_month  jun [AND] jul
#> survey_answer  no [AND] yes
#> 
dupl_sources(data_frame = df, vars = "person_id", output_as_df = TRUE)
#>   person_id  survey_month survey_answer  person_age
#> 1         1 feb [AND] jan  yes [AND] no 25 [AND] 52
#> 2         2 mar [AND] apr  no [AND] yes        <NA>
#> 3         5 jun [AND] jul  no [AND] yes        <NA>
```
