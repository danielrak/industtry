# Frequencies and proportions in one output

Combines base::table() and base::prop.table() outputs in a single one

## Usage

``` r
table_prop(..., margin = NULL, round = 3, noquote = FALSE)
```

## Arguments

- ...:

  Params. Arguments passed to base::table()

- margin:

  Integer 1L. The same argument as in base::prop.table()

- round:

  Integer 1L. Number of digits after decimal in base::prop.table()
  output

- noquote:

  Logical 1L. If TRUE, return an object of class noquote that provides
  better view of the output

## Value

Matrix or noquote matrix. Frequencies with proportions in brackets,
within a matrix

## Examples

``` r
df <- data.frame(
                 "variable_1" = c("v1_1", "v1_1",
                                  "v1_2", "v1_2", "v1_2", "v1_2"),
                 "variable_2" = c("v2_1", "v2_1", "v2_1", "v2_1",
                                  "v2_2", "v2_2")
                                  )
table_prop(df$variable_1)
#>       
#>        [,1]       
#>   v1_1 "2 (0.333)"
#>   v1_2 "4 (0.667)"
table_prop(df$variable_1, df$variable_2)
#>       
#>        v2_1        v2_2       
#>   v1_1 "2 (0.333)" "0 (0)"    
#>   v1_2 "2 (0.333)" "2 (0.333)"
table_prop(df$variable_1, df$variable_2, margin = 2, noquote = TRUE)
#>       
#>        v2_1    v2_2 
#>   v1_1 2 (0.5) 0 (0)
#>   v1_2 2 (0.5) 2 (1)
df <- data.frame("person_id" = c(1, 1, 2, 3,
                                 2, 4, 5, 5 ,1),
                 "person_age" = c(25, 25, 21, 32,
                                  21, 48, 50, 50, 52),
                 "survey_month" = c("jan", "feb", "mar", "apr",
                                    "apr", "may", "jun", "jul", "jan"),
                 "survey_answer" = c("no", "yes", "no", "yes",
                                     "yes", "yes", "no", "yes", NA))

table_prop(df$survey_month)
#>      
#>       [,1]       
#>   apr "2 (0.222)"
#>   feb "1 (0.111)"
#>   jan "2 (0.222)"
#>   jul "1 (0.111)"
#>   jun "1 (0.111)"
#>   mar "1 (0.111)"
#>   may "1 (0.111)"
table_prop(df$survey_month, df$survey_answer)
#>      
#>       no          yes        
#>   apr "0 (0)"     "2 (0.25)" 
#>   feb "0 (0)"     "1 (0.125)"
#>   jan "1 (0.125)" "0 (0)"    
#>   jul "0 (0)"     "1 (0.125)"
#>   jun "1 (0.125)" "0 (0)"    
#>   mar "1 (0.125)" "0 (0)"    
#>   may "0 (0)"     "1 (0.125)"
table_prop(df$survey_month, df$survey_answer, 
           margin = 2, round = 4)
#>      
#>       no           yes      
#>   apr "0 (0)"      "2 (0.4)"
#>   feb "0 (0)"      "1 (0.2)"
#>   jan "1 (0.3333)" "0 (0)"  
#>   jul "0 (0)"      "1 (0.2)"
#>   jun "1 (0.3333)" "0 (0)"  
#>   mar "1 (0.3333)" "0 (0)"  
#>   may "0 (0)"      "1 (0.2)"
```
