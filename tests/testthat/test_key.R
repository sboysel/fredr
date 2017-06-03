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
  # expect_error(fredr_key(env_key))
  expect_true(file.remove(renv))
  Sys.setenv(FRED_API_KEY = env_key)
  expect_message(key <- fredr_key(env_key),
                 "FRED API key set as environment variable.")
  expect_identical(key, env_key)
  expect_false(file.exists(renv))
  Sys.setenv(FRED_API_KEY = "")
  file.create(renv)
  expect_error(fredr_key(env_key),
               ".Renviron file exists in directory")
  file.remove(renv)
  # Cleanup
  Sys.setenv(FRED_API_KEY = env_key)
  if (file.exists(paste0(renv, ".bak"))) {
    file.rename(paste0(renv, ".bak"), renv)
  }
})
