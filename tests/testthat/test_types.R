library(fredr)
context("Correct objects returned")

a <- fredr(endpoint = "series/observations",
           series_id = "GNPCA")
b <- fredr_series(series_id = "GNPCA")
c <- fredr_search(search_text = "GNP")
d <- fredr(endpoint = "series/observations",
           series_id = "GNPCA",
           to_frame = FALSE)

test_that("fredr, fredr_series, and fredr_search return appropriate objects", {
  expect_is(a, c("tbl_df", "tbl", "data.frame"))
  expect_is(b, "xts")
  expect_is(c, c("tbl_df", "tbl", "data.frame"))
  expect_is(d, "response")
})
