test_that("fredr_category()", {
  skip_if_no_key()

  expect_silent(ctg <- fredr_category())
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 3)
  expect_true(nrow(ctg) == 1)
})

test_that("input is validated", {
  expect_error(fredr_category(category_id = NULL))
  expect_error(fredr_category(category_id = "a"))
  expect_error(fredr_category(category_id = 1:2))
})
