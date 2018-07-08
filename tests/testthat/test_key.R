library(fredr)
context("API Key")

test_that("fredr_set_key properly sets key", {
  backup <- Sys.getenv("FRED_API_KEY")
  fredr_set_key("foo")
  expect_identical(Sys.getenv("FRED_API_KEY"), "foo")
  fredr_set_key(backup)
  expect_identical(Sys.getenv("FRED_API_KEY"), backup)
})
