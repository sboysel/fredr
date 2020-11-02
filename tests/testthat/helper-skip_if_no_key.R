skip_if_no_key <- function() {
  skip_if(
    condition = is.null(fredr_get_key()),
    message = "FRED API key is not set."
  )
}
