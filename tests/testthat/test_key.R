library(fredr)
context("fredr_key")

test_that("fredr_key throws an error if .Renviron is present.", {
  # Backup
  env_key <- Sys.getenv("FRED_API_KEY")
  renv <- file.path(getwd(), ".Renviron")
  if (file.exists(renv)) {
    file.rename(renv, paste0(renv, ".bak"))
  }
  # Tests
  Sys.setenv(FRED_API_KEY = "")
  expect_message(fredr_key(env_key),
                 "FRED API key successfully set.")
  expect_true(file.remove(renv))
  Sys.setenv(FRED_API_KEY = env_key)
  expect_message(fredr_key(),
                 "FRED API key set as environment variable.")
  expect_false(file.exists(renv))
  file.create(renv)
  expect_message(fredr_key(),
                 "FRED API key set as environment variable.")
  file.remove(renv)
  # Cleanup
  Sys.setenv(FRED_API_KEY = env_key)
  if (file.exists(paste0(renv, ".bak"))) {
    file.rename(paste0(renv, ".bak"), renv)
  }
})
