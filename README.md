# fredr

[![Travis
branch](https://img.shields.io/travis/sboysel/fredr/master.svg?style=flat-square)](https://travis-ci.org/sboysel/fredr)
[![Codecov](https://img.shields.io/codecov/c/github/sboysel/fredr/master.svg?style=flat-square)](https://codecov.io/github/sboysel/fredr)
[![GitHub
release](https://img.shields.io/github/release/sboysel/fredr.svg?style=flat-square)](https://github.com/sboysel/fredr/releases)
[![GitHub
license](https://img.shields.io/github/license/sboysel/fredr.svg?style=flat-square)](https://opensource.org/licenses/MIT)

`fredr` seamlessly interacts with the RESTful API for [Federal Reserve Economic
Data (FRED)](https://research.stlouisfed.org/fred2/), provided by the Federal
Reserve Bank of St. Louis.  Essentially a simple wrapper of
[`httr`](https://github.com/hadley/httr),
[`dplyr`](https://github.com/hadley/dplyr), and the FRED API itself, `fredr` is
designed with simplicity and flexibility in mind.  In addition a generic query
function `fredr` to return any query as a `tbl_df`, the package also provides
convenience functions `fredr_search` and `fredr_series` to simplify the process
to finding and importing FRED series as `R` objects.  As nearly all optional
parameters supplied to these functions are relayed verbatim to the API, the 
user is strongly encouraged to read the full [FRED
API](https://research.stlouisfed.org/docs/api/fred/) to leverage the full power
of the FRED API and `fredr`. The convenience function `fredr_docs` quickly brings
up the web documentation. See the [section below](#fredr_docs) for usage
examples.
## Installation

```r
# install.packages("devtools")
devtools::install_github("sboysel/fredr")
```
## Quickstart
Load `fredr`

```r
library(fredr)
```
Set FRED API key in working directory.  You must first [obtain a FRED API
key](https://research.stlouisfed.org/docs/api/api_key.html).  It is also
recommended to reveiw the [FRED API Terms of
Use](https://research.stlouisfed.org/docs/api/terms_of_use.html).

```r
fredr_key("abcdefghijklmnopqrstuvwxyz123456")
```
Search for FRED series

```r
fredr_search(search_text = "housing")
#> Source: local data frame [1,000 x 15]
#> 
#>             id realtime_start realtime_end
#>          (chr)          (chr)        (chr)
#> 1        HOUST     2016-01-20   2016-01-20
#> 2     HOUSTNSA     2016-01-20   2016-01-20
#> 3      USSTHPI     2016-01-20   2016-01-20
#> 4  HPIPONM226S     2016-01-20   2016-01-20
#> 5  HPIPONM226N     2016-01-20   2016-01-20
#> 6  PONHPIM226S     2016-01-20   2016-01-20
#> 7  PONHPIM226N     2016-01-20   2016-01-20
#> 8      CASTHPI     2016-01-20   2016-01-20
#> 9      FLSTHPI     2016-01-20   2016-01-20
#> 10     NJSTHPI     2016-01-20   2016-01-20
#> ..         ...            ...          ...
#> Variables not shown: title (chr), observation_start (chr), observation_end
#>   (chr), frequency (chr), frequency_short (chr), units (chr), units_short
#>   (chr), seasonal_adjustment (chr), seasonal_adjustment_short (chr),
#>   last_updated (chr), popularity (int), notes (chr).
```
Get a FRED series.  Returns a `ts` object.

```r
fredr_series(series_id = "HOUST",
             observation_start = "1990-01-01",
             observation_end = "1995-01-01")
#>       Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
#> 1990 1551 1437 1289 1248 1212 1177 1171 1115 1110 1014 1145  969
#> 1991  798  965  921 1001  996 1036 1063 1049 1015 1079 1103 1079
#> 1992 1176 1250 1297 1099 1214 1145 1139 1226 1186 1244 1214 1227
#> 1993 1210 1210 1083 1258 1260 1280 1254 1300 1343 1392 1376 1533
#> 1994 1272 1337 1564 1465 1526 1409 1439 1450 1474 1450 1511 1455
#> 1995 1407
```
Leverage the native features of the FRED API

```r
fredr_series(series_id = "UNRATE",
             observation_start = "1990-01-01",
             frequency = "q",
             units = "chg")
#>      Qtr1 Qtr2 Qtr3 Qtr4
#> 1990 -0.1  0.0  0.4  0.4
#> 1991  0.5  0.2  0.1  0.2
#> 1992  0.3  0.2  0.0 -0.2
#> 1993 -0.3  0.0 -0.3 -0.2
#> 1994  0.0 -0.4 -0.2 -0.4
#> 1995 -0.1  0.2  0.0 -0.1
#> 1996 -0.1  0.0 -0.2  0.0
#> 1997 -0.1 -0.2 -0.1 -0.2
#> 1998 -0.1 -0.2  0.1 -0.1
#> 1999 -0.1  0.0 -0.1 -0.1
#> 2000 -0.1 -0.1  0.1 -0.1
#> 2001  0.3  0.2  0.4  0.7
#> 2002  0.2  0.1 -0.1  0.2
#> 2003  0.0  0.2  0.0 -0.3
#> 2004 -0.1 -0.1 -0.2  0.0
#> 2005 -0.1 -0.2 -0.1  0.0
#> 2006 -0.3 -0.1  0.0 -0.2
#> 2007  0.1  0.0  0.2  0.1
#> 2008  0.2  0.3  0.7  0.9
#> 2009  1.4  1.0  0.3  0.3
#> 2010 -0.1 -0.2 -0.1  0.0
#> 2011 -0.5  0.1 -0.1 -0.4
#> 2012 -0.3 -0.1 -0.2 -0.2
#> 2013 -0.1 -0.2 -0.2 -0.4
#> 2014 -0.2 -0.5 -0.1 -0.4
#> 2015 -0.1 -0.2 -0.2 -0.2
```
Combine with other packages for a slick workflow

```r
library(dplyr)
library(ggfortify)
fredr_series(series_id = "GNPCA",
             units = "log") %>%
  autoplot()
```

![plot of chunk fredr_series3](figure/fredr_series3-1.png) 

```r
fredr_series(series_id = "GNPCA",
             units = "log") %>%
  diff() %>%
  autoplot()
```

![plot of chunk fredr_series4](figure/fredr_series4-1.png) 

```r
fredr_series(series_id = "GNPCA",
             units = "log") %>%
  diff() %>%
  StructTS() %>%
  residuals() %>%
  acf(., main = "ACF for First Differenced real US GNP, log")
```

![plot of chunk fredr_series5](figure/fredr_series5-1.png) 

```r
fredr_search(search_text = "federal funds",
             order_by = "popularity") %>%
  slice(1) %>%
  fredr_series(series_id = .$id) %>%
  window(., start = 2000, end = c(2000, 120))
#>       Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
#> 2000 5.45 5.73 5.85 6.02 6.27 6.53 6.54 6.50 6.52 6.51 6.51 6.40
#> 2001 5.98 5.49 5.31 4.80 4.21 3.97 3.77 3.65 3.07 2.49 2.09 1.82
#> 2002 1.73 1.74 1.73 1.75 1.75 1.75 1.73 1.74 1.75 1.75 1.34 1.24
#> 2003 1.24 1.26 1.25 1.26 1.26 1.22 1.01 1.03 1.01 1.01 1.00 0.98
#> 2004 1.00 1.01 1.00 1.00 1.00 1.03 1.26 1.43 1.61 1.76 1.93 2.16
#> 2005 2.28 2.50 2.63 2.79 3.00 3.04 3.26 3.50 3.62 3.78 4.00 4.16
#> 2006 4.29 4.49 4.59 4.79 4.94 4.99 5.24 5.25 5.25 5.25 5.25 5.24
#> 2007 5.25 5.26 5.26 5.25 5.25 5.25 5.26 5.02 4.94 4.76 4.49 4.24
#> 2008 3.94 2.98 2.61 2.28 1.98 2.00 2.01 2.00 1.81 0.97 0.39 0.16
#> 2009 0.15 0.22 0.18 0.15 0.18 0.21 0.16 0.16 0.15 0.12 0.12 0.12
```

Quickly access the FRED API web documentation for any endpoint

```r
fredr_docs(endpoint = "series/observations")
```
You may also use the `params` option for `fredr_docs` to go straight to the
endpoint's Parameters section.

```r
fredr_docs(endpoint = "category/related_tags", params = TRUE)
```
You can also use the backbone function `fredr` to run more general queries
against *any* [FRED API
endpoint](https://research.stlouisfed.org/docs/api/fred/) (e.g. Categories,
Series, Sources, Releases, Tags).  This is also useful to return any arbitrary
information as a `tbl_df` object.

```r
fredr(endpoint = "tags/series", tag_names = "population;south africa")
#> Source: local data frame [32 x 15]
#> 
#>                 id realtime_start realtime_end
#>              (chr)          (chr)        (chr)
#> 1  LFWA24TTZAA647N     2016-01-20   2016-01-20
#> 2  LFWA24TTZAA647S     2016-01-20   2016-01-20
#> 3  LFWA24TTZAQ647N     2016-01-20   2016-01-20
#> 4  LFWA24TTZAQ647S     2016-01-20   2016-01-20
#> 5  LFWA25TTZAA647N     2016-01-20   2016-01-20
#> 6  LFWA25TTZAA647S     2016-01-20   2016-01-20
#> 7  LFWA25TTZAQ647N     2016-01-20   2016-01-20
#> 8  LFWA25TTZAQ647S     2016-01-20   2016-01-20
#> 9  LFWA55TTZAA647N     2016-01-20   2016-01-20
#> 10 LFWA55TTZAA647S     2016-01-20   2016-01-20
#> ..             ...            ...          ...
#> Variables not shown: title (chr), observation_start (chr), observation_end
#>   (chr), frequency (chr), frequency_short (chr), units (chr), units_short
#>   (chr), seasonal_adjustment (chr), seasonal_adjustment_short (chr),
#>   last_updated (chr), popularity (int), notes (chr).
```
## See Also
The primary goal in creating `fredr` was educational.  I also suggest you check
out several other `R` packages designed for the FRED API:

* [jcizel/FredR](https://github.com/jcizel/FredR)
* [johnlaing/rfred](https://github.com/johnlaing/rfred)
* [jdvermeire/rfred](https://github.com/jdvermeire/rfred)


