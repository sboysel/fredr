test_that("fredr_related_tags()", {
  skip_if_no_key()

  tags <- fredr_related_tags(tag_names = "gdp", limit = 20L)

  expect_s3_class(tags, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(tags) == 6)
  expect_true(nrow(tags) == 20)
})

test_that("bad tag_names are caught with a 400 error", {
  skip_if_no_key()

  expect_error(fredr_related_tags(tag_names = "xyz"), "400")
})

test_that("input is validated", {
  expect_error(fredr_related_tags())
  expect_error(fredr_related_tags(foo = "bar"))
  expect_error(fredr_related_tags(tag_names = 1))
  expect_error(fredr_related_tags(tag_names = c("a", "b")))
})
