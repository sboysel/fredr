test_that("fredr_set_key() properly sets key.", {
  original <- fredr_get_key()
  on.exit(fredr_set_key(original), add = TRUE)

  fredr_set_key("foo")
  expect_identical(fredr_get_key(), "foo")
})

test_that("fredr() throws errors if API key is not set.", {
  original <- fredr_get_key()
  on.exit(fredr_set_key(original), add = TRUE)

  fredr_set_key(NULL)

  expect_error(fredr(endpoint = "series/observations", series_id = "GNPCA"))
})
