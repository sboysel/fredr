#' Open the web documentation for a certain FRED API topic.
#'
#' Opens FRED API web documentation in a new browser tab.
#'
#' @param endpoint A string representing the desired documentation for the exact
#'				FRED API endpoint.  Default is 'base' and will open a link to
#'				\url{https://api.stlouisfed.org/docs/fred/}.
#' @param params A boolean value.  If \code{TRUE}, the documentation will be opened at
#'        the 'Paramters' section.  Default is \code{FALSE}.
#' @param debug A boolean value.  If \code{TRUE}, the documentation is not opened in a
#'        browser.  Default is \code{FALSE}.
#'
#' @references See \url{https://api.stlouisfed.org/docs/fred/}.
#'
#' @examples
#' \dontrun{
#' fredr_docs()
#' fredr_docs('category')
#' fredr_docs('series/observations')
#' fredr_docs('series/observations', params = TRUE)
#' }
#' @export
fredr_docs <- function(endpoint = "base", params = FALSE, debug = FALSE) {
  base <- "https://api.stlouisfed.org/docs/fred/"
  doc <- switch(endpoint,
            "base" = base,
            "category" = paste0(base, "category.html"),
            "category/children" = paste0(base, "category_children.html"),
            "category/related" = paste0(base, "category_related.html"),
            "category/tags" = paste0(base, "category_tags.html"),
            "category/related_tags" = paste0(base, "category_related_tags.html"),
            "releases" = paste0(base, "releases.html"),
            "releases/dates" = paste0(base, "releases_dates.html"),
            "release" = paste0(base, "release.html"),
            "release/dates" = paste0(base, "release_date.html"),
            "release/series" = paste0(base, "release_series.html"),
            "release/sources" = paste0(base, "release_sources.html"),
            "release/tags" = paste0(base, "release_tags.html"),
            "release/related_tags" = paste0(base, "release_related_tags.html"),
            "series" = paste0(base, "series.html"),
            "series/categories" = paste0(base, "series_categories.html"),
            "series/observations" = paste0(base, "series_observations.html"),
            "series/release" = paste0(base, "series_release.html"),
            "series/search" = paste0(base, "series_search.html"),
            "series/search/tags" = paste0(base, "series_search_tags.html"),
            "series/search/related_tags" = paste0(base, "series_search_releated_tags.html"),
            "series/tags" = paste0(base, "series_tags.html"),
            "series/updates" = paste0(base, "series_updates.html"),
            "series/vintagedates" = paste0(base, "series_vintagedates.html"),
            "sources" = paste0(base, "sources.html"),
            "source" = paste0(base, "source.html"),
            "source/releases" = paste0(base, "source_releases.html"),
            "tags" = paste0(base, "tags.html"),
            "related_tags" = paste0(base, "related_tags.html"),
            "tags/series" = paste0(base, "tags_series.html"))
  if (is.null(doc)) {
    stop("Invalid endpoint.")
  }
  if (params) {
    doc <- paste0(doc, "#Parameters")
  }
  if (!debug) {
    utils::browseURL(url = doc)
  }
}
