test_that("endpoints is a known data frame", {
  expect_is(fredr_endpoints, "tbl_df")
  expect_identical(nrow(fredr_endpoints), 31L)
  expect_identical(ncol(fredr_endpoints), 3L)
})
