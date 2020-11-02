# ------------------------------------------------------------------------------
# Capture arguments, validate, and return as a named list
# All validation can take place here since the defaults are NULL for everything
# and accessing a nonexistent element of a list also returns NULL

capture_args <- function(...) {

  args <- list_named(...)

  # Validation - integer values
  validate_limit(args$limit)

  # Validation - boolean values
  validate_boolean(args$include_release_dates_with_no_data, "include_release_dates_with_no_data")
  validate_boolean(args$include_observation_values, "include_observation_values")

  # Validation - dates
  date_lst <- list(
    args$observation_start,
    args$observation_end,
    args$observation_date,
    args$realtime_start,
    args$realtime_end,
    args$vintage_dates
  )

  date_nms <- list("observation_start", "observation_end", "observation_date",
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

  # Formatting - integer values
  args$limit      <- force_integer(args$limit)
  args$release_id <- force_integer(args$release_id)
  args$source_id  <- force_integer(args$source_id)
  args$element_id <- force_integer(args$element_id)

  # Formatting - boolean values
  args$include_release_dates_with_no_data <- format_boolean(
    args$include_release_dates_with_no_data
  )
  args$include_observation_values <- format_boolean(
    args$include_observation_values
  )

  # Formatting - dates
  args$observation_start <- format_fred_date(args$observation_start)
  args$observation_end   <- format_fred_date(args$observation_end)
  args$observation_date  <- format_fred_date(args$observation_date)
  args$realtime_start    <- format_fred_date(args$realtime_start)
  args$realtime_end      <- format_fred_date(args$realtime_end)
  args$vintage_dates     <- format_fred_date(args$vintage_dates)

  # Formatting - time
  args$start_time <- format_fred_time(args$start_time)
  args$end_time   <- format_fred_time(args$end_time)

  # Formatting - tags
  args$tag_names         <- format_tag_names(args$tag_names)
  args$exclude_tag_names <- format_tag_names(args$exclude_tag_names)

  # Return list for use in API call
  args
}

# ------------------------------------------------------------------------------
# Validation helpers

validate_is_class <- function(x, x_nm, x_class) {
  if(is.null(x)) return(x)

  if(!inherits_any(x, x_class)) {
    cls <- class_collapse(x_class)
    msg <- paste0("Argument `", x_nm, "` must be a ", cls, ".")
    abort(msg)
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

validate_source_id <- function(x) {
  if(is.null(x)) {
    stop("Argument `source_id` must be supplied.", call. = FALSE)
  }

  validate_is_class(x, "source_id", c("integer", "numeric"))

  if(! (length(x) == 1) ) {
    stop("Argument `source_id` must be of length 1.", call. = FALSE)
  }
}

validate_category_id <- function(x) {

  validate_is_class(x, "category_id", c("integer", "numeric"))

  if(! (length(x) == 1) ) {
    stop("Argument `category_id` must be of length 1.", call. = FALSE)
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

validate_boolean <- function(x, x_nm) {
  if(is.null(x)) return(x)
  validate_is_class(x, x_nm, "logical")
}

validate_endpoint <- function(x) {
  validate_is_class(x, "endpoint", "character")

  if(length(x) != 1) {
    abort("x must be of length 1.")
  }

  if (!is_endpoint(x)) {
    msg <- paste0(
      "`", x,
      "` is not a valid endpoint. See ",
      "https://research.stlouisfed.org/docs/api/fred/"
    )
    abort(msg)
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

class_collapse <- function(x) {
  n <- length(x)

  if (n == 0L) {
    return(character())
  }

  if (n == 1L) {
    return(paste0("`", x, "`"))
  }

  front <- x[-n]
  back <- x[n]

  front <- paste0("`", front, "`", collapse = ", ")
  back <- paste0(" or `", back, "`")

  if (n == 2L) {
    paste0(front, back)
  } else {
    paste0(front, ",",  back)
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
