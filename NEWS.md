# fredr 2.1.0

* `fredr()` / `fredr_series_observations()` now always return `realtime_start`
  and `realtime_end` columns. These are useful when setting the
  `realtime_start` / `realtime_end` arguments, or when using the `vintage_dates`
  argument (#88).

* Fixed a bug in `fredr()` / `fredr_series_observations()` so that now the 
  `vintage_dates` argument properly accepts a `Date` vector of length 1 or
  greater (#89).

# fredr 2.0.0

* fredr has been un-orphaned!

* If the FRED rate limit is hit, all fredr functions will now wait an
  appropriate amount of time before automatically attempting to make the
  request again. The rate limit seems to be 120 requests per minute, so
  fredr functions will wait 20 seconds between failed attempts, with a
  maximum of 6 failed attempts. This should be plenty of time for the rate
  limit to reset.

* Required arguments no longer have a default of `NULL`. This should make it
  easier to visually distinguish between required and optional arguments.
  Additionally, `...` have been added between the required and optional
  arguments of every function to force naming of optional arguments.

* All requests to the FRED API are now retried a maximum of 3 times on failure.
  The low level function, `fredr_request()`, has gained a `retry_times` argument
  if you need to change this on a case-by-case basis.

* There are two new functions related to the API key, `fredr_set_key()` and
  `fredr_has_key()`. These are mainly for internal usage.

# fredr 1.0.0

Initial release for CRAN.  All endpoint functions for the FRED API are now 
implemented as functions in fredr.

## Breaking changes

- `fredr()` -> `fredr_request()` (#46)
- `fredr_series()` -> `fredr_series_observations()` (alias: `fredr()`) (alias: `fredr()`) now returns a tibble (with observation date, series ID, and values columns) instead of a time series object (#46, #49).
- Remove dependencies `dplyr` and `xts` (#9).
- `fred_set_key()` no longer modifies `.Renviron`. User is encouraged to manually change `.Renviron` to persistently set FRED API key (#15).
- Explicit parameters and parameter checking for all functions (#20).
- Split `fredr_search()` into
  - `fredr_series_search_text()` (search for series by text description)
  - `fredr_series_search_text()` (search for series)
  - `fredr_series_search_tags()` (search for series tags)
  - `fredr_series_search_related_tags()` (search for related tags)
  
## New functions

Categories (#21)

- `fredr_category()` Get a FRED category
- `fredr_category_children()` Get the child categories for a specified FRED parent category
- `fredr_category_related()` Get the related categories for a FRED category.
- `fredr_category_related_tags()` Get the related FRED tags within a category
- `fredr_category_series()` Get the series in a category
- `fredr_category_tags()` Get the FRED tags for a category

Releases (#22)

- `fredr_release()` Get a release of economic data
- `fredr_release_dates()` Get release dates for a single release of economic data
- `fredr_release_related_tags()` Get the related FRED tags for one or more FRED tags within a release
- `fredr_release_series()` Get the series on a release of economic data
- `fredr_release_sources()` Get the sources for a release of economic data
- `fredr_release_tables()` Get release table trees for a given release
- `fredr_release_tags()` Get the FRED tags for a release
- `fredr_releases()` Get all releases of economic data
- `fredr_releases_dates()` Get release dates for all releases of economic data.

Series (#23)

- `fredr_series()` Return basic information for a FRED series.
- `fredr_series_categories()` Get the categories for a FRED series
- `fredr_series_release()` Get the release for a FRED series
- `fredr_series_tags()` Get the tags for a FRED series
- `fredr_series_updates()` Get a set of recently updated FRED series
- `fredr_series_vintagedates()` Get the data vintage dates for a FRED series

Sources (#24)

- `fredr_source()` Get a source of economic data
- `fredr_source_releases()` Get the releases for a source
- `fredr_sources()` Get all sources of economic data

Tags (#25)

- `fredr_tags()` Get FRED series tags
- `fredr_related_tags()` Get related FRED tags given one or more tags
- `fredr_tags_series()` Find FRED series matching tag names
  
## Other new features

- Include brief endpoint descriptions in data frame `fredr_endpoints`
- Added a `NEWS.md` file to track changes to the package.
- Added a usage vignettes (#11, #41).

# fredr 0.3.0

## Breaking changes

- `fredr_series` now returns an `xts` object.

# fredr 0.2.0

## Breaking changes

Function names conform to `fredr_*`
- `api_docs` is now `fredr_docs`
- `set_api_key` is now `fredr_key`

# fredr 0.1.0

## Initial release

`fredr` combines tools like `dplyr` and `httr` to provide a flexible but powerful wrapper for the FRED API.
- Convenience functions `fredr_search()` and `fredr_series()` for most commonly used FRED API features.
- Execute more general queries using the backbone function `fredr()`
- Bring up web documentation from the R environment with `api_docs()`
