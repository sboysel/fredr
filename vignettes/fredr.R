## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  fig.width = 7,
  fig.height = 5,
  eval = !(Sys.getenv("FRED_API_KEY") == ""),
  cache = TRUE,
  collapse = TRUE,
  comment = "#>"
)
library(fredr)
options(digits = 4)

## ----installation, eval=FALSE--------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("sboysel/fredr")

## ----fredr_load, eval=FALSE----------------------------------------------
#  library(fredr)

## ----fredr_set_key, eval=FALSE-------------------------------------------
#  fredr_set_key("abcdefghijklmnopqrstuvwxyz123456")

