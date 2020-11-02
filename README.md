
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fredr

<!-- badges: start -->

[![Codecov](https://img.shields.io/codecov/c/github/sboysel/fredr/master.svg)](https://codecov.io/github/sboysel/fredr)
[![CRAN](https://img.shields.io/cran/v/fredr.svg)](https://cran.r-project.org/web/packages/fredr/index.html)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/fredr)](https://cran.r-project.org/package=fredr)
[![R-CMD-check](https://github.com/sboysel/fredr/workflows/R-CMD-check/badge.svg)](https://github.com/sboysel/fredr/actions)
<!-- badges: end -->

fredr provides a complete set of R bindings to the [Federal Reserve of
Economic Data (FRED)](https://research.stlouisfed.org/fred2/) RESTful
API, provided by the Federal Reserve Bank of St. Louis. The functions
allow the user to search for and fetch time series observations as well
as associated metadata within the FRED database.

The core function in this package is `fredr()`, which fetches
observations for a FRED series. That said, there are many other FRED
endpoints exposed through fredr, such as `fredr_series_search_text()`,
which allows you to search for a FRED series by text.

We strongly encourage referencing the FRED API
[documentation](https://research.stlouisfed.org/docs/api/fred/) to
leverage the full power of fredr.

You’ll also need a free API key to use fredr. See `?fredr_set_key()`.

## Installation

You can download fredr from CRAN with:

``` r
install.packages("fredr")
```

To get the development version of the package:

``` r
# install.packages("devtools")
devtools::install_github("sboysel/fredr")
```

## Example

You can use `fredr()` to fetch series from FRED. This fetches the US
unemployment rate series from 1990-2000.

``` r
library(fredr)

fredr(
  series_id = "UNRATE",
  observation_start = as.Date("1990-01-01"),
  observation_end = as.Date("2000-01-01")
)
#> # A tibble: 121 x 3
#>    date       series_id value
#>    <date>     <chr>     <dbl>
#>  1 1990-01-01 UNRATE      5.4
#>  2 1990-02-01 UNRATE      5.3
#>  3 1990-03-01 UNRATE      5.2
#>  4 1990-04-01 UNRATE      5.4
#>  5 1990-05-01 UNRATE      5.4
#>  6 1990-06-01 UNRATE      5.2
#>  7 1990-07-01 UNRATE      5.5
#>  8 1990-08-01 UNRATE      5.7
#>  9 1990-09-01 UNRATE      5.9
#> 10 1990-10-01 UNRATE      5.9
#> # … with 111 more rows
```

## Usage

See the [Get
started](http://sboysel.github.io/fredr/articles/fredr.html) article.

## Documentation

See the [documentation site](http://sboysel.github.io/fredr/).

## See Also

There are several other existing R packages designed for the FRED API:

-   [business-science/tidyquant](https://github.com/business-science/tidyquant)
-   [jcizel/FredR](https://github.com/jcizel/FredR)
-   [joshuaulrich/quantmod](https://github.com/joshuaulrich/quantmod)
-   [quandl/quandl-r](https://github.com/quandl/quandl-r)
