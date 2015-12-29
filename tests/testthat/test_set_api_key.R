library(fredr)
context("set_api_key is either set of throws an error")

test_that("set_api_key throws an error if .Renviron is present.", {
  # Backup
  env_key <- Sys.getenv("FRED_API_KEY")
  renv <- file.path(normalizePath("~"), ".Renviron")
  if (file.exists(renv)) {
    file.rename(renv, paste0(renv, ".bak"))
  }
  # Tests
  Sys.setenv(FRED_API_KEY = "")
  expect_message(set_api_key(env_key),
                 "FRED API key successfully set.")
  expect_true(file.remove(renv))
  Sys.setenv(FRED_API_KEY = env_key)
  expect_message(set_api_key(),
                 "FRED API key set as environment variable.")
  expect_false(file.exists(renv))
  file.create(renv)
  expect_message(set_api_key(),
                 "FRED API key set as environment variable.")
  file.remove(renv)
  # Cleanup
  Sys.setenv(FRED_API_KEY = env_key)
  if (file.exists(paste0(renv, ".bak"))) {
    file.remove(renv)
    file.rename(paste0(renv, ".bak"), renv)
  }
})
