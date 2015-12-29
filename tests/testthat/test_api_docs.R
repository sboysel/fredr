library(fredr)
context("api_docs functions properly")

test_that("api_docs throws errors on invalid endpoints", {
  expect_error(api_docs(endpoint = "foo", debug = TRUE))
  expect_silent(api_docs(endpoint = "series",  debug = TRUE))
  expect_silent(api_docs(endpoint = "series", params = TRUE, debug = TRUE))
  expect_silent(api_docs(endpoint = "series", params = TRUE))
})
