test_that("Conversion format attributes", {

  library(magrittr)
  library(rio)

  mask_convert_r("./", "my_mask.xlsx")
  expect_true(file.exists("./my_mask.xlsx"))
  file.remove("./my_mask.xlsx")
  expect_false(file.exists("./my_mask.xlsx"))

  mask_convert_r("./", "my_mask_again.xlsx")
  expect_true(file.exists("./my_mask_again.xlsx"))
  mask <- import("./my_mask_again.xlsx")
  expect_true("mask" %in% ls())
  file.remove("./my_mask_again.xlsx")
  expect_false(file.exists("./my_mask_again.xlsx"))
  expect_identical(class(mask), "data.frame")
  expect_identical(names(mask),
                   c("folder_path", "file",
                     "converted_file", "to_convert"))
})

rm(list = ls())
gc()
