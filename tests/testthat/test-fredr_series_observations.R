test_that("fredr() aliases fredr_series_observations()", {
  skip_if_no_key()

  expect_identical(
    fredr(series_id = "GNPCA", limit = 2),
    fredr_series_observations(series_id = "GNPCA", limit = 2)
  )
})

test_that("fredr_series_observations() works", {
  skip_if_no_key()

  series <- fredr_series_observations(series_id = "GNPCA", limit = 20L)

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(series$date, "Date")
  expect_type(series$series_id, "character")
  expect_type(series$value, "double")
  expect_s3_class(series$realtime_start, "Date")
  expect_s3_class(series$realtime_end, "Date")
  expect_true(ncol(series) == 5)
  expect_true(nrow(series) == 20)
})

test_that("fredr_series_observations() properly returns zero row tibble", {
  skip_if_no_key()

  series <- fredr::fredr_series_observations(
    series_id = "GNPCA",
    observation_start = as.Date("2050-01-01")
  )

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(series$date, "Date")
  expect_type(series$series_id, "character")
  expect_type(series$value, "double")
  expect_s3_class(series$realtime_start, "Date")
  expect_s3_class(series$realtime_end, "Date")
  expect_true(ncol(series) == 5)
  expect_true(nrow(series) == 0)
})

test_that("fredr_series_observations() throws errors for bad parameters", {
  expect_error(fredr_series_observations())
  expect_error(fredr_series_observations(foo = "bar"))
  expect_error(fredr_series_observations(series_id = 1))
  expect_error(fredr_series_observations(series_id = c("a", "b")))
})

test_that("vintage_dates parameter accepts a vector of dates", {
  skip_if_no_key()

  # An update to GDPC1 was done on 2001-07-27,
  # back-updating the value on 2000-01-01. This vintage_dates range
  # captures the value before and after that transition.
  vintage_dates <- as.Date(c("2001-07-25", "2001-07-28"))

  result <- fredr_series_observations(
    series_id = "GDPC1",
    observation_start = as.Date("2000-01-01"),
    observation_end = as.Date("2000-01-01"),
    vintage_dates = vintage_dates
  )

  expect_realtime_start <- as.Date(c("2001-07-25", "2001-07-27"))
  expect_realtime_end <- as.Date(c("2001-07-26", "2001-07-28"))

  expect_identical(nrow(result), 2L)
  expect_identical(result$realtime_start, expect_realtime_start)
  expect_identical(result$realtime_end, expect_realtime_end)
})

test_that("validate_series_id() throws proper errors", {
  expect_error(validate_series_id(NULL))
  expect_error(validate_series_id(1))
  expect_error(validate_series_id(c("a", "b")))
})
