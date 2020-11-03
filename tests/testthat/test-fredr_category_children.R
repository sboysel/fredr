test_that("fredr_category_children()", {
  skip_if_no_key()

  ctg <- fredr_category_children(category_id = 0)

  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 3)
  expect_true(nrow(ctg) == 8)
})

test_that("input is validated", {
  expect_error(fredr_category_children(category_id = NULL))
  expect_error(fredr_category_children(category_id = "a"))
  expect_error(fredr_category_children(category_id = 1:2))
})
