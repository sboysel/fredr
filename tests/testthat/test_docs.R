library(fredr)
context("fredr_docs")

test_that("fredr_docs throws errors on invalid endpoints", {
  expect_error(fredr_docs(endpoint = "foo", debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series",  debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series", params = TRUE, debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series", params = TRUE))
})
