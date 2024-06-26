# WARNING - Generated by {fusen} from dev/flat_utils.Rmd: do not edit by hand

test_that("Valid outputs are consistent", {
  
  df <- data.frame("person_id" = c(1, 1, 2, 3,
                                   2, 4, 5, 5 ,1),
                   "person_age" = c(25, 25, 21, 32,
                                    21, 48, 50, 50, 52),
                   "survey_month" = c("jan", "feb", "mar", "apr",
                                      "apr", "may", "jun", "jul", "jan"),
                   "survey_answer" = c("no", "yes", "no", "yes",
                                       "yes", "yes", "no", "yes", NA))
  
  expect_equal(object = table_prop(df$survey_month), 
               expected = structure(
                 c(
                   "2 (0.222)",
                   "1 (0.111)",
                   "2 (0.222)",
                   "1 (0.111)",
                   "1 (0.111)",
                   "1 (0.111)",
                   "1 (0.111)"
                 ),
                 dim = c(7L, 1L),
                 dimnames = structure(list(
                   c("apr", "feb", "jan", "jul", "jun", "mar", "may"), NULL
                 ), names = c("", ""))
               ))
  
  expect_equal(object = table_prop(df$survey_month, df$survey_answer), 
               expected = structure(
                 c(
                   "0 (0)",
                   "0 (0)",
                   "1 (0.125)",
                   "0 (0)",
                   "1 (0.125)",
                   "1 (0.125)",
                   "0 (0)",
                   "2 (0.25)",
                   "1 (0.125)",
                   "0 (0)",
                   "1 (0.125)",
                   "0 (0)",
                   "0 (0)",
                   "1 (0.125)"
                 ),
                 dim = c(7L, 2L),
                 dimnames = structure(list(
                   c("apr", "feb", "jan", "jul", "jun", "mar", "may"), c("no", "yes")
                 ), names = c("", ""))
               ))
  
  expect_equal(
    object = table_prop(df$survey_month, df$survey_answer, 
           margin = 2, round = 4), 
    expected = structure(
      c(
        "0 (0)",
        "0 (0)",
        "1 (0.3333)",
        "0 (0)",
        "1 (0.3333)",
        "1 (0.3333)",
        "0 (0)",
        "2 (0.4)",
        "1 (0.2)",
        "0 (0)",
        "1 (0.2)",
        "0 (0)",
        "0 (0)",
        "1 (0.2)"
      ),
      dim = c(7L, 2L),
      dimnames = structure(list(
        c("apr", "feb", "jan", "jul", "jun", "mar", "may"), c("no", "yes")
      ), names = c("", ""))
    )
  )
})
