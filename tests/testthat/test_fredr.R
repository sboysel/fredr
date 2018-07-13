library(fredr)
context("Core functions")

test_that("fredr() throws proper errors and messages", {
  # unset API key
  key_backup <- Sys.getenv("FRED_API_KEY")
  fredr_set_key("")
  expect_error(fredr(endpoint = "series"))
  fredr_set_key(key_backup)
  # print HTTP request
  expect_message(fredr(endpoint = "series", series_id = "GNPCA", print_req = TRUE), regexp = "GNPCA")
  # bad endpoint
  expect_error(fredr(endpoint = "foo"))
})

test_that("fredr() returns proper objects", {
  expect_silent(resp <- fredr(endpoint = "series", series_id = "GNPCA", to_frame = FALSE))
  expect_silent(frame <- fredr(endpoint = "series", series_id = "GNPCA"))
  expect_s3_class(resp, "response")
  expect_s3_class(frame, c("tbl_df", "tbl", "data.frame"))
})
