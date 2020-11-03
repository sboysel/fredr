test_that("fredr_release_tables()", {
  skip_if_no_key()

  release <- fredr_release_tables(release_id = 10L)

  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
})

test_that("input is validated", {
  expect_error(fredr_release_tables())
  expect_error(fredr_release_tables(release_id = 10L, include_observation_values = 1), "`include_observation_values` must be a single logical")
  expect_error(fredr_release_tables(release_id = 10L, include_observation_values = "true"), "`include_observation_values` must be a single logical")
  expect_error(fredr_release_tables(release_id = 10L, observation_date = 1), "`observation_date` must be a `Date`")
  expect_error(fredr_release_tables(release_id = 10L, observation_date = "a"), "`observation_date` must be a `Date`")
})
