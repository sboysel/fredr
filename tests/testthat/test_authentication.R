library(fredr)
context("Authentication functions")

test_that("fredr_set_key() properly sets key.", {
  backup <- Sys.getenv("FRED_API_KEY")
  fredr_set_key("foo")
  expect_identical(Sys.getenv("FRED_API_KEY"), "foo")
  fredr_set_key(backup)
  expect_identical(Sys.getenv("FRED_API_KEY"), backup)
})

test_that("fredr() throws errors if API key is not set.", {
  env_key <- Sys.getenv("FRED_API_KEY")
  Sys.setenv(FRED_API_KEY = "")
  expect_error(fredr(endpoint = "series/observations", series_id = "GNPCA"))
  Sys.setenv(FRED_API_KEY = env_key)
})
