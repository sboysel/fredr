# fredr

<!-- badges: start -->
  [![CRAN](https://www.r-pkg.org/badges/version/fredr)](https://cran.r-project.org/package=fredr)
  [![CRAN Downloads](https://cranlogs.r-pkg.org/badges/fredr)](https://cran.r-project.org/package=fredr)
  [![R build status](https://github.com/sboysel/fredr/workflows/R-CMD-check/badge.svg)](https://github.com/sboysel/fredr/actions)
  [![Codecov](https://codecov.io/gh/sboysel/fredr/branch/master/graph/badge.svg)](https://codecov.io/gh/sboysel/fredr?branch=master)
<!-- badges: end -->

`fredr` provides a complete set of `R` bindings to the [Federal Reserve Economic
Data (FRED)](https://research.stlouisfed.org/fred2/) RESTful API, provided by 
the Federal Reserve Bank of St. Louis.  The functions allow the user to search 
for and fetch time series observations as well as associated metadata within the FRED 
database.  The core functions are

- `fredr_set_key()` - Set the required FRED API key for the session.
- `fredr()` or `fredr_series_observations()` - Fetch a FRED series.
- `fredr_series_search_text()` - Search for a FRED series by text.
- `fredr_request()` - Send a general request to the FRED API.

Objects are returned as `tibbles`.  The user is strongly encouraged to read the 
full [FRED API](https://research.stlouisfed.org/docs/api/fred/) documentation to 
leverage the full power of `fredr` and the FRED API.

## Installation


```r
install.packages("fredr")
```

To get the development version of the package:


```r
# install.packages("devtools")
devtools::install_github("sboysel/fredr")
```

## Usage

See the [Get started](http://sboysel.github.io/fredr/articles/fredr.html) article.

## Documentation

See the [documentation site](http://sboysel.github.io/fredr/).

## See Also

There are several existing `R` packages designed for the FRED API:

* [business-science/tidyquant](https://github.com/business-science/tidyquant)
* [jcizel/FredR](https://github.com/jcizel/FredR)
* [joshuaulrich/quantmod](https://github.com/joshuaulrich/quantmod)
* [quandl/quandl-r](https://github.com/quandl/quandl-r)


