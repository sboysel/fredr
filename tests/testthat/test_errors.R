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
  expect_error(fredr_series(series_id = 1))
  expect_error(fredr_series(series_id = "FOOBAR"))
  expect_error(fredr_series(endpoint = "bad_endpoint", series_id = "FOOBAR"))
  expect_error(fredr_series(series_id = "GNPCA", frequency = "foo"))
})

test_that("fredr_search* take distinct parameters", {
  expect_error(fredr_search(text = "foo"))
  expect_error(fredr_search_id(id = "foo"))
  expect_error(fredr_search_tags(x = "foo"))
  expect_error(fredr_search_rel_tags(search = "foo", tag = "bar"))
  expect_silent(fredr_search(search = "foo", order_by = "popularity"))
  expect_silent(fredr_search("foo", order_by = "popularity"))
  expect_silent(fredr_search_id(search = "foo", order_by = "popularity"))
  expect_silent(fredr_search_tags(search = "foo", order_by = "popularity"))
  expect_silent(fredr_search_rel_tags(search = "foo", tag_names = "30-year", order_by = "popularity"))
  expect_silent(fredr_tags(tag_group_id = "geo"))
  expect_error(fredr_search_rel_tags(search = "foo", tag_names = "bar", order_by = "popularity"))
})

test_that("fredr with print_req returns the correct message", {
  req <- paste0("https://api.stlouisfed.org/fred/series/observations")
  expect_message(fredr(endpoint = "series/observations",
                       series_id = "GNPCA",
                       print_req = TRUE),
                 req)
})
