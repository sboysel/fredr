library(fredr)
context("Endpoint functions: Releases")

test_that("fredr_release()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release(release_id = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 6)
  expect_true(nrow(release) == 1)
  # errors
  expect_error(fredr_release())
})

test_that("fredr_release_dates()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_dates(release_id = 10L, limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 2)
  expect_true(nrow(release) == 10)
  # errors
  expect_error(fredr_release_dates())
})


test_that("fredr_releases()", {
  skip_if_no_key()
  expect_silent(release <- fredr_releases(limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 7)
  expect_true(nrow(release) == 10)
})

test_that("fredr_releases_dates()", {
  skip_if_no_key()
  expect_silent(release <- fredr_releases_dates(limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 3)
  expect_true(nrow(release) == 10)
  # errors
  expect_error(fredr_release_dates(include_release_dates_with_no_data = 1))
  expect_error(fredr_release_dates(include_release_dates_with_no_data = "true"))
})

test_that("fredr_release_tags()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_tags(release_id = 10L, limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 6)
  expect_true(nrow(release) == 10)
  # errors
  expect_error(fredr_release_tags())
})

test_that("fredr_release_related_tags()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_related_tags(
    release_id = 10L,
    tag_names = "usa",
    limit = 10L
  ))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 6)
  expect_true(nrow(release) == 10)
  # errors
  expect_error(fredr_release_related_tags())
  expect_error(fredr_release_related_tags(release_id = 10L))
  expect_error(fredr_release_related_tags(tag_names = "usa"))
})

test_that("fredr_release_series()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_series(release_id = 10L, limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 16)
  expect_true(nrow(release) == 10)
  # errors
  expect_error(fredr_release_series())
})

test_that("fredr_release_sources()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_sources(release_id = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 5)
  expect_true(nrow(release) == 1)
  # errors
  expect_error(fredr_release_sources())
})

test_that("fredr_release_tables()", {
  skip_if_no_key()
  expect_silent(release <- fredr_release_tables(release_id = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  # errors
  expect_error(fredr_release_tables())
  expect_error(fredr_release_tables(release_id = 10L, include_observation_values = 1))
  expect_error(fredr_release_tables(release_id = 10L, include_observation_values = "true"))
  expect_error(fredr_release_tables(release_id = 10L, observation_date = 1))
  expect_error(fredr_release_tables(release_id = 10L, observation_date = "a"))
})
