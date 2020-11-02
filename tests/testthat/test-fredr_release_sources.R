test_that("fredr_release_sources()", {
  skip_if_no_key()

  expect_silent(release <- fredr_release_sources(release_id = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 5)
  expect_true(nrow(release) == 1)
})

test_that("input is validated", {
  expect_error(fredr_release_sources())
})
