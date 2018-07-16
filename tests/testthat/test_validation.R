library(fredr)
context("Validation functions")

test_that("capture_args() returns a named list", {
  expect_silent(capture_args())
  expect_is(capture_args(), "list")
  expect_error(capture_args(limit = "1000"))
  expect_error(capture_args(limit = c(1000L, 1000L)))
  expect_identical(capture_args(limit = 1000.00)$limit, 1000L)
})

test_that("capture_args() validation: limit", {
  expect_error(capture_args(limit = "1000"))
  expect_error(capture_args(limit = c(1000L, 1000L)))
  expect_identical(capture_args(limit = 1000.00)$limit, 1000L)
})

test_that("capture_args() validation: dates", {
  # Date objects pass
  expect_silent(good_args <- capture_args(
    observation_start = Sys.Date(),
    observation_end = Sys.Date(),
    realtime_start = Sys.Date(),
    realtime_end = Sys.Date(),
    vintage_dates = Sys.Date()
  ))
  # format_date returns a character date
  expect_true(all(sapply(good_args, is.character)))
  # non-Date objects throw errors
  expect_error(capture_args(observation_start = "a"))
  expect_error(capture_args(observation_end = 1))
  expect_error(capture_args(realtime_start = TRUE))
  expect_error(capture_args(realtime_end = list(a = 1, b = 2)))
  expect_error(capture_args(vintage_dates = mtcars))
  # Unformatted character dates throw errors
  expect_error(capture_args(observation_start = "2000-01-01"))
  expect_error(capture_args(observation_end = "2000-01-01"))
  expect_error(capture_args(realtime_start = "2000-01-01"))
  expect_error(capture_args(realtime_end = "2000-01-01"))
  expect_error(capture_args(vintage_dates = "2000-01-01"))
})

test_that("capture_args() validation: time", {
  # Date objects pass
  expect_silent(good_args <- capture_args(
    start_time = Sys.time() - (7 * 24 * 60 * 60),
    end_time = Sys.time()
  ))
  # format_date returns a character date
  expect_true(all(sapply(good_args, is.character)))
  # non-Date objects throw errors
  expect_error(capture_args(start_time = "a"))
  expect_error(capture_args(start_time = 1))
})

test_that("validate_required_string_param()", {
  good <- "good"
  bad <- NULL
  numeric <- 1
  length2 <- c("a", "b")
  expect_silent(validate_required_string_param(good))
  expect_error(validate_required_string_param(bad))
  expect_error(validate_required_string_param(numeric))
  expect_error(validate_required_string_param(length2))
})

test_that("validate_endpoint()", {
  expect_silent(validate_endpoint("series/observations"))
  expect_error(validate_endpoint("bad"))
  expect_error(validate_endpoint(1))
  expect_error(validate_endpoint(c("series/observations", "series/observations")))
})

test_that("validate_series_id()", {
  good <- "my_series_id"
  numeric <- 1
  length2 <- 1:2
  expect_silent(validate_series_id(good))
  expect_error(validate_series_id(numeric))
  expect_error(validate_series_id(length2))
})

test_that("validate_release_id()", {
  good <- 1
  char <- "bad"
  length2 <- 1:2
  expect_silent(validate_release_id(good))
  expect_error(validate_release_id(char))
  expect_error(validate_release_id(length2))
})

test_that("validate_boolean()", {
  good <- TRUE
  numeric <- 1
  length2 <- c("a", "b")
  expect_silent(validate_boolean(good))
  expect_error(validate_boolean(numeric))
  expect_error(validate_boolean(length2))
})

test_that("format_boolean()", {
  expect_silent(format_boolean(TRUE))
  expect_silent(format_boolean(FALSE))
  expect_silent(format_boolean(1L))
  expect_silent(format_boolean(0L))
  expect_identical(format_boolean(TRUE), "true")
  expect_identical(format_boolean(FALSE), "false")
  expect_identical(format_boolean(1L), "true")
  expect_identical(format_boolean(0L), "false")
  expect_null(format_boolean(NULL))
})


