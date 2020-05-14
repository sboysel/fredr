library(fredr)
context("Documentation function")

test_that("fredr_docs just works...", {
  expect_silent(fredr_docs())
})
