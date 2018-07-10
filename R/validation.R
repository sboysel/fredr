validate_series_id <- function(x) {
  if(is.null(x))
    return(x)

  if(!is.character(x)) {
    stop("Argument `series_id` must be a character.", call. = FALSE)
  }

  if(! (length(x) == 1) ) {
    stop("Argument `series_id` must be of length 1.", call. = FALSE)
  }
}

validate_is_date <- function(x, x_nm) {
  if(is.null(x))
    return(x)

  if(!inherits(x, "Date"))
    stop(paste0("Argument `", x_nm, "` must be of class `Date`."), call. = FALSE)
}

