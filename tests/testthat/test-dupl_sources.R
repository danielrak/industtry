# WARNING - Generated by {fusen} from dev/flat_dupl_show.Rmd: do not edit by hand

test_that("Valid outputs are consistent", {
  
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
  
  expect_equal(
    object = dupl_sources(data_frame = df, vars = "person_id"), 
    expected = list(
      `Duplicate sources where person_id equals 1` = structure(
        list(values = c(
          "1", "feb [AND] jan", "yes [AND] no", "25 [AND] 52"
        )),
        row.names = c("person_id", "survey_month", "survey_answer", "person_age"),
        class = "data.frame"
      ),
      `Duplicate sources where person_id equals 2` = structure(
        list(values = c("2", "mar [AND] apr", "no [AND] yes")),
        row.names = c("person_id", "survey_month", "survey_answer"),
        class = "data.frame"
      ),
      `Duplicate sources where person_id equals 5` = structure(
        list(values = c("5", "jun [AND] jul", "no [AND] yes")),
        row.names = c("person_id", "survey_month", "survey_answer"),
        class = "data.frame"
      )
    )
  )
  
  expect_equal(
    object = dupl_sources(data_frame = df, vars = "person_id", output_as_df = TRUE), 
    expected = structure(
      list(
        person_id = c("1", "2", "5"),
        survey_month = c("feb [AND] jan", "mar [AND] apr", "jun [AND] jul"),
        survey_answer = c("yes [AND] no", "no [AND] yes", "no [AND] yes"),
        person_age = c("25 [AND] 52", NA, NA)
      ),
      row.names = c(NA, -3L),
      class = "data.frame"
    )
  )
  
  expect_equal(
    object = dupl_sources(data_frame = df, vars = c("person_id", "survey_month")), 
    expected = list(
      `Duplicate sources where person_id-survey_month equals 1 jan` = structure(
        list(values = "1 jan"), 
        row.names = "person_id-survey_month", class = "data.frame"),
      `Duplicate sources where person_id-survey_month equals 25 [AND] 52` = structure(
        list(values = "25 [AND] 52"),
        row.names = "person_id-survey_month",
        class = "data.frame"
      )
    )
  )
  
  expect_equal(
    object = dupl_sources(data_frame = df, vars = c("person_id", "survey_month"), 
                          output_as_df = TRUE),
    expected = structure(
      list(`person_id-survey_month` = c("1 jan", "25 [AND] 52")),
      row.names = c(NA, -2L),
      class = "data.frame"))
})
