test_that("fredr_releases_dates()", {
  skip_if_no_key()

  release <- fredr_releases_dates(limit = 10L)

  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 3)
  expect_true(nrow(release) == 10)
})

test_that("input is validated", {
  expect_error(fredr_releases_dates(include_release_dates_with_no_data = 1))
  expect_error(fredr_releases_dates(include_release_dates_with_no_data = "true"))
})
