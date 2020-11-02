test_that("fredr_category_related_tags()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_related_tags(category_id = 0L, tag_names = "gnp"))
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 0)
  expect_true(nrow(ctg) == 0)
})

test_that("input is validated", {
  expect_error(fredr_category_related_tags(category_id = NULL, tag_names = "gnp"))
  expect_error(fredr_category_related_tags(category_id = "a", tag_names = "gnp"))
  expect_error(fredr_category_related_tags(category_id = 1:2, tag_names = "gnp"))
  expect_error(fredr_category_related_tags(category_id = 0, tag_names = NULL))
  expect_error(fredr_category_related_tags(category_id = 0, tag_names = NA))
  expect_error(fredr_category_related_tags(category_id = 0, tag_names = 1))
  expect_error(fredr_category_related_tags(category_id = 0, tag_names = c("a", "b")))
})
