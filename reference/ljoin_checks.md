# Perform a classical dplyr::left_join() and add check information related to join

Perform a classical dplyr::left_join() and add check information related
to join

## Usage

``` r
ljoin_checks(ltable, rtable, ...)
```

## Arguments

- ltable:

  Data.frame. Left data frame in the join

- rtable:

  Data.frame. Right data frame in the join

- ...:

  Params. Any other arguments of dplyr::left_join()

## Value

Data.frame. Output of dplyr::left_join() with messages on number of
observations in left, right and joined data frames and list of common
variables between ltable and rtable

## Examples

``` r
left_table <- data.frame("person_id" = c(1, 1, 2, 3,
                                 2, 4, 5, 5 ,1),
                 "person_age" = c(25, 25, 21, 32,
                                  21, 48, 50, 50, 52),
                 "survey_month" = c("jan", "feb", "mar", "apr",
                                    "apr", "may", "jun", "jul", "jan"),
                 "survey_answer" = c("no", "yes", "no", "yes",
                                     "yes", "yes", "no", "yes", NA))

right_table <- data.frame("person_id" = c(2, 5, 4, 3, 1), 
                          "person_name" = c("John", "Marie", "Pierre", "Marc", "Jimmy"))

list("left_table" = left_table, 
     "right_table" = right_table)
#> $left_table
#>   person_id person_age survey_month survey_answer
#> 1         1         25          jan            no
#> 2         1         25          feb           yes
#> 3         2         21          mar            no
#> 4         3         32          apr           yes
#> 5         2         21          apr           yes
#> 6         4         48          may           yes
#> 7         5         50          jun            no
#> 8         5         50          jul           yes
#> 9         1         52          jan          <NA>
#> 
#> $right_table
#>   person_id person_name
#> 1         2        John
#> 2         5       Marie
#> 3         4      Pierre
#> 4         3        Marc
#> 5         1       Jimmy
#> 

ljoin_checks(left_table, right_table, by = "person_id")
#> Checks : 
#> ltable rows : 9
#> rtable rows :5
#> jtable rows : 9
#> person_id are common var names accross the two tables
#>   person_id person_age survey_month survey_answer person_name
#> 1         1         25          jan            no       Jimmy
#> 2         1         25          feb           yes       Jimmy
#> 3         2         21          mar            no        John
#> 4         3         32          apr           yes        Marc
#> 5         2         21          apr           yes        John
#> 6         4         48          may           yes      Pierre
#> 7         5         50          jun            no       Marie
#> 8         5         50          jul           yes       Marie
#> 9         1         52          jan          <NA>       Jimmy
```
