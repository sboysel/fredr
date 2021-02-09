#' Send a request to the FRED API
#'
#' Send a general request to the FRED API by specifying an endpoint and a
#' sequence of parameters.  The `fredr_request()` function forms and submits a
#' request to a specified endpoint of the FRED API.  The result is either the
#' `response` object from [httr::GET()] or the response parsed as a `tibble`.
#'
#' @param endpoint A string representing the FRED API endpoint of interest. See
#'   [fredr_endpoints] for a list of endpoint possible values. _Required
#'   parameter._
#' @param ... A series of named parameters to be used in the query.  Must be of
#'   the form `param_key = "param_value"`.  Acceptable parameters are
#'   endpoint-specific. See the [fredr_endpoints] data frame for a list of
#'   endpoints and [fredr_docs()] to access the web documentation for each
#'   endpoint function.
#' @param to_frame A boolean value indicating whether or not the response should
#'   be parsed and formatted as a data frame.  If `FALSE`, a `response` object
#'   is returned and further processing can be done with [httr::content()].
#'   Default is `TRUE`.
#' @param print_req A boolean value indicating whether or not the request should
#'   be printed as well.  Useful for debugging.  Default is `FALSE`.
#' @param retry_times An integer indicating the maximum number of requests to
#'   attempt. Passed directly to [httr::RETRY()].  Default is 3.
#' @return If `to_frame = TRUE`, a `tibble` containing the parsed response. If
#'   `to_frame = FALSE`, a `response` object returned directly from
#'   [httr::GET()].
#'
#' @section API Documentation:
#'
#'   [FRED API](https://fred.stlouisfed.org/docs/api/fred/)
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_request(
#'   endpoint = "series/observations",
#'   series_id = "GNPCA",
#'   observation_start = "1990-01-01",
#'   observation_end = "2000-01-01"
#' )
#'
#' # Compare to to_frame = `FALSE`
#' resp <- fredr_request(
#'   endpoint = "series/observations",
#'   series_id = "GNPCA",
#'   observation_start = "1990-01-01",
#'   observation_end = "2000-01-01",
#'   to_frame = FALSE
#' )
#' }
#' @export
fredr_request <- function(endpoint,
                          ...,
                          to_frame = TRUE,
                          print_req = FALSE,
                          retry_times = 3L) {
  if (!fredr_has_key()) {
    abort("FRED API key must be set. See `?fredr_set_key`.")
  }

  validate_endpoint(endpoint)

  params <- list(...)
  params$api_key <- fredr_get_key()
  params$file_type <- "json"

  resp <- fredr_download_loop(endpoint, params, retry_times)

  if (print_req) {
    inform(resp$url)
  }

  validate_status(resp)

  if (!to_frame) {
    return(resp)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))

  if (endpoint %in% c("category",
                      "category/children",
                      "category/related",
                      "series/categories")) {
    frame <- tibble::as_tibble(parsed$categories)
    return(frame)
  }

  if (endpoint == "category/series") {
    frame <- tibble::as_tibble(parsed$series)
    return(frame)
  }

  if (endpoint %in% c("category/tags",
                      "category/related_tags",
                      "release/tags",
                      "release/related_tags",
                      "series/search/tags",
                      "series/search/related_tags",
                      "series/tags",
                      "tags",
                      "related_tags")) {
    frame <- tibble::as_tibble(parsed$tags)
    return(frame)
  }

  if (endpoint %in% c("releases",
                      "release",
                      "series/release",
                      "source/releases")) {
    frame <- tibble::as_tibble(parsed$releases)
    return(frame)
  }

  if (endpoint %in% c("releases/dates",
                      "release/dates")) {
    frame <- tibble::as_tibble(parsed$release_dates)
    return(frame)
  }

  if (endpoint %in% c("release/series",
                      "series",
                      "series/search",
                      "series/updates",
                      "tags/series")) {
    frame <- tibble::as_tibble(parsed$seriess)
    return(frame)
  }

  if (endpoint == "release/sources") {
    frame <- tibble::as_tibble(parsed$sources)
    return(frame)
  }

  if (endpoint == "series/observations") {
    frame <- tibble::as_tibble(parsed$observations)
    return(frame)
  }

  if (endpoint == "series/vintagedates") {
    frame <- tibble::tibble(vintage_dates = parsed$vintage_dates)
    return(frame)
  }

  if (endpoint %in% c("source",
                      "sources")) {
    frame <- tibble::as_tibble(parsed$sources)
    return(frame)
  }

  if (endpoint == "release/tables") {
    frame <- tibble::enframe(parsed$elements)
    return(frame)
  }

  abort("Internal error: Should have returned by now.")
}

# According to an email with the FRED team, the current rate limit is
# 120 requests per minute. This will attempt the request, and if we
# get rate limited then it will wait 20 seconds before trying again. We
# try a maximum of 6 times before giving up, which gives a total of around
# two minutes for the rate limit to reset, which should be plenty of time.
fredr_download_loop <- function(endpoint, params, retry_times) {
  done <- FALSE
  code_exceeded_rate_limit <- 429L

  attempt <- 1L
  max_attempt <- 6L

  while (!done) {
    response <- fredr_download(endpoint, params, retry_times)

    # Not rate limited - done
    if (response$status_code != code_exceeded_rate_limit) {
      done <- TRUE
      next
    }

    if (attempt == max_attempt) {
      abort(paste0(
        "Maximum number of attempts reached. ",
        "Please wait before submitting another request."
      ))
    }

    inform(paste0(
      "You have hit the rate limit of 120 requests / minute. ",
      "Waiting 20 seconds before retrying request. ",
      "This is attempt ", attempt, " of ", max_attempt, "."
    ))

    Sys.sleep(20)

    attempt <- attempt + 1L
  }

  response
}

fredr_download <- function(endpoint, params, retry_times) {
  httr::RETRY(
    verb = "GET",
    url = "https://api.stlouisfed.org/",
    path = paste0("fred/", endpoint),
    query = params,
    times = retry_times,
    terminate_on = fredr_termination_codes()
  )
}

fredr_termination_codes <- function() {
  # https://fred.stlouisfed.org/docs/api/fred/errors.html
  code_bad_request <- 400L
  code_not_found <- 404L
  code_locked <- 423L
  code_internal_server_error <- 500L
  code_exceeded_rate_limit <- 429L

  c(
    code_bad_request,
    code_not_found,
    code_locked,
    code_internal_server_error,
    code_exceeded_rate_limit
  )
}

validate_status <- function(response) {
  type <- httr::http_type(response)

  if (!identical(type, "application/json")) {
    # Something went wrong before we could even request a JSON response.
    # The returned response is likely XML, but we don't guess, and instead
    # extract a basic error message with `http_status()`.
    # This can happen when the FRED API is completely down, where we
    # can get a 500 error and an XML reponse.
    status <- httr::http_status(response)
    message <- status$message
    abort(message)
  }

  if (response$status_code == 200) {
    # All good
    return(invisible(response))
  }

  content <- httr::content(response, "text")
  content <- jsonlite::fromJSON(content)

  error_code <- content$error_code
  error_message <- content$error_message

  if (is_null(error_code) || is_null(error_message)) {
    # Completely unexpected JSON error format.
    # Do the best we can with `http_status()`.
    status <- httr::http_status(response)
    message <- status$message
    abort(message)
  }

  # Known error format
  message <- paste0(error_code, ": ", error_message)

  abort(message)
}
