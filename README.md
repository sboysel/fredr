
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fredr

<!-- badges: start -->

[![Codecov](https://img.shields.io/codecov/c/github/sboysel/fredr/master.svg)](https://codecov.io/github/sboysel/fredr)
[![CRAN](https://img.shields.io/cran/v/fredr.svg)](https://cran.r-project.org/package=fredr)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/fredr)](https://cran.r-project.org/package=fredr)
[![R-CMD-check](https://github.com/sboysel/fredr/workflows/R-CMD-check/badge.svg)](https://github.com/sboysel/fredr/actions)
<!-- badges: end -->

fredr provides a complete set of R bindings to the [Federal Reserve of
Economic Data (FRED)](https://fred.stlouisfed.org/) RESTful API,
provided by the Federal Reserve Bank of St. Louis. The functions allow
the user to search for and fetch time series observations as well as
associated metadata within the FRED database.

The core function in this package is `fredr()`, which fetches
observations for a FRED series. That said, there are many other FRED
endpoints exposed through fredr, such as `fredr_series_search_text()`,
which allows you to search for a FRED series by text.

We strongly encourage referencing the FRED API
[documentation](https://fred.stlouisfed.org/docs/api/fred/) to leverage
the full power of fredr.

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
#> # A tibble: 121 x 5
#>    date       series_id value realtime_start realtime_end
#>    <date>     <chr>     <dbl> <date>         <date>      
#>  1 1990-01-01 UNRATE      5.4 2021-01-29     2021-01-29  
#>  2 1990-02-01 UNRATE      5.3 2021-01-29     2021-01-29  
#>  3 1990-03-01 UNRATE      5.2 2021-01-29     2021-01-29  
#>  4 1990-04-01 UNRATE      5.4 2021-01-29     2021-01-29  
#>  5 1990-05-01 UNRATE      5.4 2021-01-29     2021-01-29  
#>  6 1990-06-01 UNRATE      5.2 2021-01-29     2021-01-29  
#>  7 1990-07-01 UNRATE      5.5 2021-01-29     2021-01-29  
#>  8 1990-08-01 UNRATE      5.7 2021-01-29     2021-01-29  
#>  9 1990-09-01 UNRATE      5.9 2021-01-29     2021-01-29  
#> 10 1990-10-01 UNRATE      5.9 2021-01-29     2021-01-29  
#> # … with 111 more rows
```

## Usage

See the [Get
started](http://sboysel.github.io/fredr/articles/fredr.html) article.

## Documentation

See the [documentation site](http://sboysel.github.io/fredr/).

## Restrictions

According to the FRED team, the following data sources do not permit
redistribution through the FRED API:

-   ICE Libor Rates
-   ICE Swap Rates
-   LBMA Gold Price: Daily Prices
-   LBMA Silver Price: Daily Prices

If you need data from any of these sources, it is recommended to
download the data directly from the FRED website. The series in these
sources can be found [here](https://fred.stlouisfed.org/source?soid=62).

## Code of Conduct

Please note that the fredr project is released with a [Contributor Code
of Conduct](http://sboysel.github.io/fredr/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.

## See Also

There are several other existing R packages designed for the FRED API:

-   [business-science/tidyquant](https://github.com/business-science/tidyquant)
-   [jcizel/FredR](https://github.com/jcizel/FredR)
-   [joshuaulrich/quantmod](https://github.com/joshuaulrich/quantmod)
-   [quandl/quandl-r](https://github.com/quandl/quandl-r)
