# WARNING - Generated by {fusen} from dev/flat_inspect_vars.Rmd: do not edit by hand

test_that("Valid outputs are consistent", {
  
  library(magrittr)
  data("CO2")
  
  insp <- inspect(CO2)
  
  expect_equal(
    object = insp, 
    expected = structure(
      list(variables = c("Plant", "Plant", "Type", "Treatment", 
                         "conc", "uptake"), 
           class = c("ordered", "factor", "factor", "factor", 
                     "numeric", "numeric"), 
           nb_distinct = c(12L, 12L, 2L, 2L, 7L, 
                           76L), 
           prop_distinct = c(0.142857142857143, 0.142857142857143, 
                             0.0238095238095238, 0.0238095238095238, 0.0833333333333333, 0.904761904761905
                                                                                             ), 
           nb_na = c(0L, 0L, 0L, 0L, 0L, 0L), 
           prop_na = c(0, 0, 0, 0, 
                       0, 0), 
           nb_void = c(0L, 0L, 0L, 0L, 0L, 0L), 
           prop_void = c(0, 
                         0, 0, 0, 0, 0), 
           nchars = c("3", "3", "6 / 11", "7 / 10", "2 / 3 / 4", 
                      "2 / 3 / 4"), 
           modalities = c("Qn1 / Qn2 / Qn3 / Qc1 / Qc3 / Qc2 / Mn3 / Mn2 / Mn1 / Mc2", 
                          "Qn1 / Qn2 / Qn3 / Qc1 / Qc3 / Qc2 / Mn3 / Mn2 / Mn1 / Mc2", 
                          "Quebec / Mississippi", "nonchilled / chilled", "95 / 175 / 250 / 350 / 500 / 675 / 1000", 
                          "7.7 / 9.3 / 10.5 / 10.6 / 11.3 / 11.4 / 12 / 12.3 / 12.5 / 13")), 
      class = c("tbl_df", "tbl", "data.frame"), 
      row.names = c(NA, -6L)))
  })

test_that("Errors are consistent", {
  
  library(magrittr)
  data(CO2)
  co2_matrix <- as.matrix(CO2)
  
  expect_error(
    object = inspect(co2_matrix), 
    regexp = "data_frame must be an object of data.frame class")
})
