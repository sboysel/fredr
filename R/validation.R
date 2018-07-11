validate_series_id <- function(x) {
  if(is.null(x)) {
    stop("Argument `series_id` must be supplied.", call. = FALSE)
  }

  validate_is_class(x, "series_id", "character")

  if(! (length(x) == 1) ) {
    stop("Argument `series_id` must be of length 1.", call. = FALSE)
  }
}

validate_is_class <- function(x, x_nm, x_class) {
  if(is.null(x))
    return(x)

  if(!inherits(x, x_class)) {
    msg <- paste0("Argument `", x_nm, "` must be a `", x_class, "`.")
    stop(msg, call. = FALSE)
  }
}
