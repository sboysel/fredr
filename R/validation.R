# ------------------------------------------------------------------------------
# Capture arguments, validate, and return as a named list
# All validation can take place here since the defaults are NULL for everything
# and accessing a nonexistent element of a list also returns NULL

capture_args <- function(...,
                         limit = NULL,
                         offset = NULL,
                         order_by = NULL,
                         sort_order = NULL,
                         filter_variable = NULL,
                         filter_value = NULL,
                         observation_start = NULL,
                         observation_end = NULL,
                         observation_date = NULL,
                         realtime_start = NULL,
                         realtime_end = NULL,
                         vintage_dates = NULL,
                         include_release_dates_with_no_data = NULL,
                         include_observation_values = NULL,
                         start_time = NULL,
                         end_time = NULL,
                         series_id = NULL,
                         category_id = NULL,
                         release_id = NULL,
                         source_id = NULL,
                         element_id = NULL,
                         tag_names = NULL,
                         exclude_tag_names = NULL,
                         tag_group_id = NULL,
                         tag_search_text = NULL,
                         search_text = NULL,
                         series_search_text = NULL,
                         frequency = NULL,
                         aggregation_method = NULL,
                         units = NULL,
                         output_type = NULL) {
  if (rlang::dots_n(...) > 0L) {
    abort("Internal error: Dots are not empty.")
  }

  args <- list(
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    filter_variable = filter_variable,
    filter_value = filter_value,
    observation_start = observation_start,
    observation_end = observation_end,
    observation_date = observation_date,
    realtime_start = realtime_start,
    realtime_end = realtime_end,
    vintage_dates = vintage_dates,
    include_release_dates_with_no_data = include_release_dates_with_no_data,
    include_observation_values = include_observation_values,
    start_time = start_time,
    end_time = end_time,
    series_id = series_id,
    category_id = category_id,
    release_id = release_id,
    source_id = source_id,
    element_id = element_id,
    tag_names = tag_names,
    exclude_tag_names = exclude_tag_names,
    tag_group_id = tag_group_id,
    tag_search_text = tag_search_text,
    search_text = search_text,
    series_search_text = series_search_text,
    frequency = frequency,
    aggregation_method = aggregation_method,
    units = units,
    output_type = output_type
  )

  # `NULL` arguments delete themselves automatically
  # through `$<-` handling of `NULL`
  args$limit <- check_limit(args$limit)
  args$offset <- check_offset(args$offset)
  args$order_by <- check_order_by(args$order_by)
  args$sort_order <- check_sort_order(args$sort_order)
  args$filter_variable <- check_filter_variable(args$filter_variable)
  args$filter_value <- check_filter_value(args$filter_value)
  args$observation_start <- check_observation_start(args$observation_start)
  args$observation_end <- check_observation_end(args$observation_end)
  args$observation_date <- check_observation_date(args$observation_date)
  args$realtime_start <- check_realtime_start(args$realtime_start)
  args$realtime_end <- check_realtime_end(args$realtime_end)
  args$vintage_dates <- check_vintage_dates(args$vintage_dates)
  args$include_release_dates_with_no_data <- check_include_release_dates_with_no_data(args$include_release_dates_with_no_data)
  args$include_observation_values <- check_include_observation_values(args$include_observation_values)
  args$start_time <- check_start_time(args$start_time)
  args$end_time <- check_start_time(args$end_time)
  args$series_id <- check_series_id(args$series_id)
  args$category_id <- check_category_id(args$category_id)
  args$release_id <- check_release_id(args$release_id)
  args$source_id <- check_source_id(args$source_id)
  args$element_id <- check_element_id(args$element_id)
  args$tag_names <- check_tag_names(args$tag_names)
  args$exclude_tag_names <- check_exclude_tag_names(args$exclude_tag_names)
  args$tag_group_id <- check_tag_group_id(args$tag_group_id)
  args$tag_search_text <- check_tag_search_text(args$tag_search_text)
  args$search_text <- check_search_text(args$search_text)
  args$series_search_text <- check_series_search_text(args$series_search_text)
  args$frequency <- check_frequency(args$frequency)
  args$aggregation_method <- check_aggregation_method(args$aggregation_method)
  args$units <- check_units(args$units)
  args$output_type <- check_output_type(args$output_type)

  args
}

# ------------------------------------------------------------------------------

check_limit <- function(x) {
  check_scalar_positive_integerish(x, "limit")
}
check_offset <- function(x) {
  check_scalar_positive_integerish(x, "offset")
}
check_category_id <- function(x) {
  check_scalar_positive_integerish(x, "category_id")
}
check_release_id <- function(x) {
  check_scalar_positive_integerish(x, "release_id")
}
check_source_id <- function(x) {
  check_scalar_positive_integerish(x, "source_id")
}
check_element_id <- function(x) {
  check_scalar_positive_integerish(x, "element_id")
}
check_output_type <- function(x) {
  check_scalar_positive_integerish(x, "output_type")
}

check_observation_start <- function(x) {
  check_scalar_date(x, "observation_start")
}
check_observation_end <- function(x) {
  check_scalar_date(x, "observation_end")
}
check_observation_date <- function(x) {
  check_scalar_date(x, "observation_date")
}
check_realtime_start <- function(x) {
  check_scalar_date(x, "realtime_start")
}
check_realtime_end <- function(x) {
  check_scalar_date(x, "realtime_end")
}

check_vintage_dates <- function(x) {
  check_date(x, "vintage_dates")
}

check_include_release_dates_with_no_data <- function(x) {
  check_bool(x, "include_release_dates_with_no_data")
}
check_include_observation_values <- function(x) {
  check_bool(x, "include_observation_values")
}

check_start_time <- function(x) {
  check_scalar_datetime(x, "start_time")
}
check_end_time <- function(x) {
  check_scalar_datetime(x, "end_time")
}

check_tag_names <- function(x) {
  check_tag(x, "tag_names")
}
check_exclude_tag_names <- function(x) {
  check_tag(x, "exclude_tag_names")
}

check_series_id <- function(x) {
  check_scalar_character(x, "series_id")
}
check_tag_group_id <- function(x) {
  check_scalar_character(x, "tag_group_id")
}
check_tag_search_text <- function(x) {
  check_scalar_character(x, "tag_search_text")
}
check_search_text <- function(x) {
  check_scalar_character(x, "search_text")
}
check_series_search_text <- function(x) {
  check_scalar_character(x, "series_search_text")
}
check_order_by <- function(x) {
  check_scalar_character(x, "order_by")
}
check_sort_order <- function(x) {
  check_scalar_character(x, "sort_order")
}
check_filter_variable <- function(x) {
  check_scalar_character(x, "filter_variable")
}
check_filter_value <- function(x) {
  check_scalar_character(x, "filter_value")
}
check_frequency <- function(x) {
  check_scalar_character(x, "frequency")
}
check_aggregation_method <- function(x) {
  check_scalar_character(x, "aggregation_method")
}
check_units <- function(x) {
  check_scalar_character(x, "units")
}

# ------------------------------------------------------------------------------

check_scalar_positive_integerish <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  if (!is_integerish(x, n = 1L, finite = TRUE)) {
    msg <- sprintf("`%s` must be a single finite integer.", x_nm)
    abort(msg)
  }

  x <- as.integer(x)

  if(x < 0) {
    msg <- sprintf("`%s` must be a positive integer.", x_nm)
    abort(msg)
  }

  x
}

check_scalar_date <- function(x, x_nm) {
  x <- check_date(x, x_nm)
  x <- check_scalar(x, x_nm)
  x
}

check_date <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  x <- check_is_class(x, x_nm, "Date")

  format_fred_date(x)
}

check_scalar_datetime <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  x <- check_is_class(x, x_nm, c("POSIXct", "POSIXlt", "Date"))
  x <- check_scalar(x, x_nm)

  format_fred_time(x)
}

check_bool <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  if (!is_bool(x)) {
    msg <- sprintf("`%s` must be a single logical value.", x_nm)
    abort(msg)
  }

  format_fred_bool(x)
}

check_tag <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  x <- check_character(x, x_nm)

  format_fred_tag_names(x)
}

check_character <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  if (!is.character(x)) {
    msg <- sprintf("`%s` must be a character vector.", x_nm)
    abort(msg)
  }

  x
}

check_scalar_character <- function(x, x_nm) {
  x <- check_character(x, x_nm)
  check_scalar(x, x_nm)
}

check_is_class <- function(x, x_nm, x_class) {
  if(is.null(x)) {
    return(x)
  }

  if(!inherits_any(x, x_class)) {
    cls <- class_collapse(x_class)
    msg <- paste0("Argument `", x_nm, "` must be a ", cls, ".")
    abort(msg)
  }

  x
}

check_scalar <- function(x, x_nm) {
  if(is.null(x)) {
    return(x)
  }

  if (length(x) != 1L) {
    msg <- sprintf("Argument `%s` must have length 1, not %i.", x_nm, length(x))
    abort(msg)
  }

  x
}

check_not_null <- function(x, x_nm) {
  if (is.null(x)) {
    msg <- sprintf("`%s` must not be `NULL`.", x_nm)
    abort(msg)
  }

  x
}

# ------------------------------------------------------------------------------

validate_endpoint <- function(x) {
  check_is_class(x, "endpoint", "character")

  if(length(x) != 1) {
    abort("x must be of length 1.")
  }

  if (!is_endpoint(x)) {
    msg <- paste0(
      "`", x,
      "` is not a valid endpoint. See ",
      "https://fred.stlouisfed.org/docs/api/fred/"
    )
    abort(msg)
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

# ------------------------------------------------------------------------------
# Extra helpers

format_fred_date <- function(x) {
  format(x, "%Y-%m-%d")
}
format_fred_time <- function(x) {
  format(x, "%Y%m%d%H%M%S")
}
format_fred_bool <- function(x) {
  ifelse(x, "true", "false")
}
format_fred_tag_names <- function(x) {
  gsub("\\+", " ", x)
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


