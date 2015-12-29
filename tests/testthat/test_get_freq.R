library(fredr)
context("Check get_freq")

test_that("get_freq functions properly", {
  expect_error(get_freq())
  expect_error(get_freq(series_id = "foo"))
  expect_silent(get_freq(series_id = "GNPCA"))
  expect_is(get_freq(series_id = "GNPCA"), "character")
})
