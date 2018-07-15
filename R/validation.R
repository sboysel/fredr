# ------------------------------------------------------------------------------
# Capture arguments, validate, and return as a named list
# All validation can take place here since the defaults are NULL for everything
# and accessing a nonexistent element of a list also returns NULL

capture_args <- function(...) {

  args <- list_named(...)

  # Validation - limit
  validate_limit(args$limit)

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

  # Validation - times
  time_lst <- list(
    args$start_time,
    args$end_time
  )

  time_nms <- list("start_time", "end_time")

  mapply(
    validate_is_class,
    time_lst, time_nms,
    MoreArgs = list(x_class = c("POSIXct", "POSIXlt", "POSIXt"))
  )

  # Validation - boolean values
  validate_boolean(args$include_release_dates_with_no_data)
  validate_boolean(args$include_observation_values)

  # Limit formatting
  args$limit <- force_integer(args$limit)

  # Formatting - dates
  args$observation_start <- format_fred_date(args$observation_start)
  args$observation_end   <- format_fred_date(args$observation_end)
  args$realtime_start    <- format_fred_date(args$realtime_start)
  args$realtime_end      <- format_fred_date(args$realtime_end)
  args$vintage_dates     <- format_fred_date(args$vintage_dates)

  # Formatting - tags
  args$tag_names         <- format_tag_names(args$tag_names)
  args$exclude_tag_names <- format_tag_names(args$exclude_tag_names)

  # Formatting - time
  args$start_time <- format_fred_time(args$start_time)
  args$end_time   <- format_fred_time(args$end_time)

  # Boolean formatting
  args$include_release_dates_with_no_data <- format_boolean(
    args$include_release_dates_with_no_data
  )
  args$include_observation_values <- format_boolean(
    args$include_observation_values
  )

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

validate_series_id <- function(x) {
  if(is.null(x)) {
    stop("Argument `series_id` must be supplied.", call. = FALSE)
  }

  validate_is_class(x, "series_id", "character")

  if(! (length(x) == 1) ) {
    stop("Argument `series_id` must be of length 1.", call. = FALSE)
  }
}

validate_release_id <- function(x) {
  if(is.null(x)) {
    stop("Argument `release_id` must be supplied.", call. = FALSE)
  }

  validate_is_class(x, "release_id", c("integer", "numeric"))

  if(! (length(x) == 1) ) {
    stop("Argument `release_id` must be of length 1.", call. = FALSE)
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

validate_boolean <- function(x) {
  if(is.null(x)) return(x)

  validate_is_class(x, "include_release_dates_with_no_data", "logical")

}

validate_endpoint <- function(x) {

  validate_is_class(x, "endpoint", "character")

  if (!is_endpoint(x)) {
    msg <- paste0(
      "`", x,
      "` is not a valid endpoint.  See ",
      "https://research.stlouisfed.org/docs/api/fred/"
    )
    stop(msg,  call. = FALSE)
  }

}

# ------------------------------------------------------------------------------
# Extra helpers

format_fred_date <- function(x) {
  if(is.null(x)) return(x)

  format(x, "%Y-%m-%d")
}

format_tag_names <- function(x) {
  if(is.null(x)) return(x)

  gsub("\\+", " ", x)
}

format_fred_time <- function(x) {
  if(is.null(x)) return(x)

  format(x, "%Y%m%d%H%M%S")
}

format_boolean <- function(x) {
  if(is.null(x)) return(x)

  ifelse(x, "true", "false")

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

is_endpoint <- function(x) {
  x %in% c(
    "category",
    "category/children",
    "category/related",
    "category/series",
    "category/tags",
    "category/related_tags",
    "series",
    "series/search",
    "series/updates",
    "series/categories",
    "series/search/tags",
    "series/search/related_tags",
    "series/release",
    "series/observations",
    "series/vintagedates",
    "series/tags",
    "release",
    "releases",
    "releases/dates",
    "release/dates",
    "release/series",
    "release/sources",
    "release/tags",
    "release/related_tags",
    "release/tables",
    "source",
    "sources",
    "source/releases",
    "tags",
    "related_tags",
    "tags/series"
  )
}
