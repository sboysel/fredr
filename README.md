# fredr

[![Travis
branch](https://img.shields.io/travis/sboysel/fredr/master.svg?style=flat-square)](https://travis-ci.org/sboysel/fredr)
[![AppVeyor Build Status](https://ci.appveyor.com/project/sboysel/fredr/branch/master)](https://ci.appveyor.com/project/sboysel/fredr/branch/master)
[![Codecov](https://img.shields.io/codecov/c/github/sboysel/fredr/master.svg?style=flat-square)](https://codecov.io/github/sboysel/fredr)
[![GitHub
release](https://img.shields.io/github/release/sboysel/fredr.svg?style=flat-square)](https://github.com/sboysel/fredr/releases)
[![GitHub
license](https://img.shields.io/github/license/sboysel/fredr.svg?style=flat-square)](https://opensource.org/licenses/MIT)

`fredr` provides a complete set of `R` bindings to the [Federal Reserve Economic
Data (FRED)](https://research.stlouisfed.org/fred2/) RESTful API for, provided by 
the Federal Reserve Bank of St. Louis.  The functions allow the user to search 
for and fetch time series observations and associated metadata within the FRED 
database.  The core functions are

- `fredr_set_key()` - Set the required FRED API key for the session.
- `fredr_series_observations()` - Fetch a FRED series.
- `fredr_series_search_text()` - Search for a FRED series by text.
- `fredr()` - Send a general request to the FRED API.

Objects are returned as `tibbles`.  The user is strongly encouraged to read the 
full [FRED API](https://research.stlouisfed.org/docs/api/fred/) documentation to 
leverage the full power of `fredr` and the FRED API.

## Installation


```r
# install.packages("devtools")
devtools::install_github("sboysel/fredr")
```

## Usage

See the [Get started](http://sboysel.github.io/fredr/articles/fredr.html) article.

## See Also

There are several existing `R` packages designed for the FRED API:

* [business-science/tidyquant](https://github.com/business-science/tidyquant)
* [jcizel/FredR](https://github.com/jcizel/FredR)
* [joshuaulrich/quantmod](https://github.com/joshuaulrich/quantmod)
* [quandl/quandl-r](https://github.com/quandl/quandl-r)
* [johnlaing/rfred](https://github.com/johnlaing/rfred)
* [jdvermeire/rfred](https://github.com/jdvermeire/rfred)


