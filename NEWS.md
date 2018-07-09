# fredr 0.3.0.9000

## Breaking changes

- `fredr_series` now returns a tibble instead of a time series object.  Remove dependencies `dplyr` and `xts` (#9).
- `fred_key` -> `fred_set_key` no longer modifies `.Renviron`. User is encouraged to manually change `.Renviron` to persistently set FRED API key (#15).
- Split `fredr_search` into
  - `fredr_search` (search for series by text description)
  - `fredr_search_id` (search for series)
  - `fredr_search_tags` (search for series tags)
  - `fredr_search_rel_tags` (search for related tags)
  
## New features

- `fredr_tags` function to list and or search for series tags
- Include brief endpoint descriptions in data frame `fredr_endpoints`
- Added a `NEWS.md` file to track changes to the package.
- Added a usage vignette (#11).

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
