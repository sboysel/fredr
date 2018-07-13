# ------------------------------------------------------------------------------
# Capture arguments, validate, and return as a named list
# All validation can take place here since the defaults are NULL for everything
# and accessing a nonexistent element of a list also returns NULL

capture_args <- function(...) {

  args <- list_named(...)

  # Validation - limit
  validate_limit(args$limit)
  args$limit <- force_integer(args$limit)

  # Validation - dates
  date_lst <- list(
    args$observation_start,
    args$observation_end,
    args$realtime_start,
    args$realtime_end,
    args$vintage_dates
  )

  date_nms <- list("observation_start", "observation_end",
                   "realtime_start", "realtime_end", "vintage_dates")

  mapply(validate_is_class, date_lst, date_nms, MoreArgs = list(x_class = "Date"))

  # Date formatting
  args$observation_start <- format_fred_date(args$observation_start)
  args$observation_end   <- format_fred_date(args$observation_end)
  args$realtime_start    <- format_fred_date(args$realtime_start)
  args$realtime_end      <- format_fred_date(args$realtime_end)
  args$vintage_dates     <- format_fred_date(args$vintage_dates)

  # Return list for use in API call
  args
}

# ------------------------------------------------------------------------------
# Validation helpers

validate_is_class <- function(x, x_nm, x_class) {
  if(is.null(x)) return(x)

  if(!inherits(x, x_class)) {
    msg <- paste0("Argument `", x_nm, "` must be a `", x_class, "`.")
    stop(msg, call. = FALSE)
  }
}

validate_limit <- function(x) {
  if(is.null(x)) return(x)

  validate_is_class(x, "limit", c("integer", "numeric"))

  if (!length(x) == 1) {
    stop("`limit` must be of length 1.", call. = FALSE)
  }

  if(x <= 0) {
    stop("`limit` must be a non-negative integer.", call. = FALSE)
  }
}

validate_required_string_param <- function(x) {

  x_nm <- deparse(substitute(x))

  if(is.null(x)) {
    msg <- paste0("Argument `", x_nm, "` must be supplied.")
    stop(msg, call. = FALSE)
  }

  validate_is_class(x, x_nm, "character")

  if(! (length(x) == 1) ) {
    msg <- paste0("Argument `", x_nm, "` must be of length 1.")
    stop(msg, call. = FALSE)
  }

}

# ------------------------------------------------------------------------------
# Extra helpers

format_fred_date <- function(x) {
  if(is.null(x)) return(x)

  format(x, "%Y-%m-%d")
}

list_named <- function(...) {
  lapply(rlang::enquos(..., .named = TRUE), rlang::eval_tidy)
}

force_integer <- function(x) {
  if(is.null(x)) return(x)

  if(is.integer(x)) {
    x
  } else {
    as.integer(x)
  }
}
