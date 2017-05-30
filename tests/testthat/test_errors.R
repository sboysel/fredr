library(fredr)
context("fredr-based functions")

test_that("fredr throws errors for bad requests", {
  expect_error(fredr())
  expect_error(fredr(endpoint = "series/observations", series_id = "FOOBAR"))
  expect_error(fredr(endpoint = "bad_endpoint", series_id = "GNPCA"))
  expect_error(fredr(endpoint = "series/observations", bad_parameter = "foo"))

})

test_that("fredr throws errors if API key is not set", {
  env_key <- Sys.getenv("FRED_API_KEY")
  Sys.setenv(FRED_API_KEY = "")
  expect_error(fredr(endpoint = "series/observations", series_id = "GNPCA"))
  Sys.setenv(FRED_API_KEY = env_key)
})

test_that("fredr_series throws errors", {
  expect_error(fredr_series())
  expect_error(fredr_series(series_id = "FOOBAR"))
  expect_error(fredr_series(endpoint = "bad_endpoint", series_id = "FOOBAR"))
  expect_error(fredr_series(series_id = "GNPCA", frequency = "foo"))
})

test_that("fredr_search throws errors with incompatible options", {
  expect_error(fredr_search(search_field = "foo"))
  expect_error(fredr_search(search_field = "series"))
  expect_error(fredr_search(search_field = "tags"))
  expect_error(fredr_search(search_field = "related_tags"))
  expect_error(fredr_search(search_field = "series",
                            series_search_text = "housing"))
  expect_error(fredr_search(search_field = "tags",
                            search_text = "housing"))
  expect_error(fredr_search(search_field = "related_tags",
                            search_text = "housing"))
  expect_silent(fredr_search(search_field = "series",
                             search_text = "housing"))
  expect_silent(fredr_search(search_field = "tags",
                             series_search_text = "housing"))
  expect_silent(fredr_search(search_field = "related_tags",
                             series_search_text = "housing",
                             tag_names = "usa;monthly"))
})

test_that("fredr with print_req returns the correct message", {
  req <- paste0("https://api.stlouisfed.org/fred/series/observations")
  expect_message(fredr(endpoint = "series/observations",
                       series_id = "GNPCA",
                       print_req = TRUE),
                 req)
})
