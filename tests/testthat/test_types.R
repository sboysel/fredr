library(fredr)
context("Object types")

a <- fredr(endpoint = "series/observations",
           series_id = "GNPCA")
b <- fredr_series(series_id = "GNPCA")
c1 <- fredr_search(search_text = "GNP")
c2 <- fredr_search_id(search_text = "GNP")
c3 <- fredr_search_tags(series_search_text = "GNP")
c4 <- fredr_search_rel_tags(series_search_text = "GDP", tag_names = "GNP")
d <- fredr(endpoint = "series/observations",
           series_id = "GNPCA",
           to_frame = FALSE)
e <- fredr_tags(tag_names = "gdp;oecd")

test_that("fredr, fredr_series, and fredr_search return appropriate objects", {
  expect_is(a, c("tbl_df", "tbl", "data.frame"))
  expect_is(b, c("tbl_df", "tbl", "data.frame"))
  expect_is(c1, c("tbl_df", "tbl", "data.frame"))
  expect_is(c2, c("tbl_df", "tbl", "data.frame"))
  expect_is(c3, c("tbl_df", "tbl", "data.frame"))
  expect_is(c4, c("tbl_df", "tbl", "data.frame"))
  expect_is(d, "response")
  expect_is(e, c("tbl_df", "tbl", "data.frame"))
})
