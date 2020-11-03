test_that("fredr_release_series()", {
  skip_if_no_key()

  release <- fredr_release_series(release_id = 10L, limit = 10L)

  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 16)
  expect_true(nrow(release) == 10)
})

test_that("bad `exclude_tag_names` throw 400 errors", {
  skip_if_no_key()

  expect_error(fredr_release_series(release_id = 1, exclude_tag_names = "foo"), "400")
})

test_that("input is validated", {
  expect_error(fredr_release_series())
})


