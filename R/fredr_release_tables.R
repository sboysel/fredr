#' Get release table trees for a given release
#'
#' You can go directly to the tree structure by passing the appropriate
#' `element_id`. You may also use a drill-down approach to start at the root
#' (top most) element by leaving the `element_id` off.
#'
#' @param release_id An integer ID of the release. _Required parameter._
#'
#' @param element_id An integer ID for the desired release table element.
#'
#' @param include_observation_values A boolean indicating if observations should
#' be returned with the release table element. Observations will only be returned
#' for a series type element.  Default is `FALSE`.
#'
#' @param observation_date A `Date` indicating which observation date to include
#' with the release table.  Default is `9999-12-31` (latest date available).
#'
#' @return A `tibble` object with nested results.
#'
#' @section API Documentation:
#'
#' [fred/release/tables](https://research.stlouisfed.org/docs/api/fred/release_tables.html)
#'
#' @seealso [fredr_releases()], [fredr_release_dates()], [fredr_releases_dates()],
#' [fredr_release()], [fredr_release_series()], [fredr_release_sources()],
#' [fredr_release_tags()], [fredr_release_related_tags()]
#'
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_release_tables(release_id = 10L)
#'
#' # Digging further into a release element
#' fredr_release_tables(release_id = 53L, element_id = 12886)
#' }
#' @export
fredr_release_tables <- function(release_id = NULL,
                                 element_id = NULL,
                                 include_observation_values = NULL,
                                 observation_date = NULL) {

  validate_release_id(release_id)

  user_args <- capture_args(
    release_id = release_id,
    element_id = element_id,
    include_observation_values = include_observation_values,
    observation_date = observation_date
  )

  fredr_args <- list(
    endpoint = "release/tables"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
