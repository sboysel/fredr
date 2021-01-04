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
  expect_type(series[[2]], "character")
  expect_type(series[[3]], "double")
  expect_true(ncol(series) == 3)
  expect_true(nrow(series) == 20)
})

test_that("fredr_series_observations() properly returns zero row tibble", {
  skip_if_no_key()

  series <- fredr::fredr_series_observations(
    series_id = "GNPCA",
    observation_start = as.Date("2050-01-01")
  )

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 3)
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

  x = as.Date(c("1991-12-04", "1991-12-20"))
  expect_silent(fredr_series_observations(
    series_id = "GNPCA1", vintage_dates = x[1], limit = 2)
  )
  expect_silent(fredr_series_observations(
    series_id = "GNPCA1", vintage_dates = x, limit = 2)
  )
})

test_that("validate_series_id() throws proper errors", {
  expect_error(validate_series_id(NULL))
  expect_error(validate_series_id(1))
  expect_error(validate_series_id(c("a", "b")))
})
