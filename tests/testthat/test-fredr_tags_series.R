test_that("fredr_tags_series()", {
  skip_if_no_key()

  expect_silent(tags <- fredr_tags_series(tag_names = "gdp", limit = 20L))
  expect_s3_class(tags, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(tags) == 16)
  expect_true(nrow(tags) == 20)
})

test_that("bad tag_names are caught with a 400 error", {
  skip_if_no_key()

  expect_error(fredr_tags_series(tag_names = "xyz"), "400")
})

test_that("input is validated", {
  expect_error(fredr_tags_series())
  expect_error(fredr_tags_series(foo = "bar"))
  expect_error(fredr_tags_series(tag_names = 1))
  expect_error(fredr_tags_series(tag_names = c("a", "b")))
})
