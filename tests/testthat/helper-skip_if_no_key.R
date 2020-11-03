skip_if_no_key <- function() {
  skip_if(
    condition = !fredr_has_key(),
    message = "FRED API key is not set."
  )
}
