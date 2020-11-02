test_that("fredr_release_related_tags()", {
  skip_if_no_key()

  expect_silent(
    release <- fredr_release_related_tags(
      release_id = 10L,
      tag_names = "usa",
      limit = 10L
    )
  )

  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 6)
  expect_true(nrow(release) == 10)
})

test_that("errors with 400 code on bad tag_names", {
  skip_if_no_key()

  expect_error(fredr_release_related_tags(release_id = 1, tag_names = "x"), "400")
})

test_that("input is validated", {
  expect_error(fredr_release_related_tags())
})

test_that("must have both release_id and tag_names", {
  expect_error(fredr_release_related_tags(release_id = 10L))
  expect_error(fredr_release_related_tags(tag_names = "usa"))
})
