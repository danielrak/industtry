test_that("chars_structure() output", {

  library(stringr)
  context("Character manipulations outputs")

  input <- c("ABC123", "DE4F56", "789GHI")
  output <- chars_structure(input)

  expect_identical(class(input), "character")
  expect_identical(class(output), "character")
  expect_identical(length(input), length(output))
  expect_identical(output,
                   c("3A, 3D", "2A, 1D, 1A, 2D", "3D, 3A"))


})

rm(list = ls())
gc()
