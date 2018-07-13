library(fredr)
context("Documentation functions")

test_that("fredr_docs throws errors on invalid endpoints", {
  expect_error(fredr_docs(endpoint = 1, debug = TRUE))
  expect_error(fredr_docs(endpoint = c("a", "b"), debug = TRUE))
  expect_error(fredr_docs(params = TRUE, debug = TRUE))
  expect_error(fredr_docs(endpoint = "foo"))
  expect_error(fredr_docs(endpoint = "foo", params = TRUE))
  expect_silent(fredr_docs())
  expect_silent(fredr_docs(debug = TRUE))
  expect_silent(fredr_docs(endpoint = "foo", debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series",  debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series", params = TRUE, debug = TRUE))
  expect_silent(fredr_docs(endpoint = "series", params = TRUE))
})

test_that("fredr_docs returns the appropriate URL when debug = TRUE", {
  expect_identical(fredr_docs(debug = TRUE), "https://api.stlouisfed.org/docs/fred/")
  expect_identical(fredr_docs(endpoint = "series", debug = TRUE), "https://api.stlouisfed.org/docs/fred/series.html")
  expect_identical(fredr_docs(endpoint = "series", params = TRUE, debug = TRUE), "https://api.stlouisfed.org/docs/fred/series.html#Parameters")
})
