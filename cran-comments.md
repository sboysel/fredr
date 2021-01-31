## Test environments
* local OS X install, R 4.0.3
* ubuntu 16.04 (on travis-ci), R 4.0.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

There are no reverse dependencies.

## 2.1.0 Submission

This is a minor release, fixing a bug and adding new columns to the output of `fredr()`.

## 2.0.0 Resubmission

This is a re-submission of fredr 2.0.0. See below for the explanation of why
fredr was archived to begin with, and our fix.

### Review 1 - 2020-11-11

> Please always make sure to reset to user's options(), working directory
or par() after you changed it in examples and vignettes and demos.
e.g.:
old <- options(digits = 3)
...
options(old)

The fredr vignettes were using `options(digits = 4)`. This has been removed.

> Have the issues why your package was archived been fixed?
Please explain this in the submission comments.

fredr was archived because `fredr_docs()` was hitting a URL that used to be
valid, but changed somewhere along the way to be invalid. This broke a test.
We have updated `fredr_docs()` to be simpler, and to only browse a URL that
should be more stable.

## 2.0.0 Submission

This is a submission of fredr 2.0.0 intended to un-orphan the fredr package. 

## Resubmission

This is a resubmission. In this version I have:

* Changed \dontrun{} to \donttest{} for function examples sections.
* Properly commented out non-code lines in examples sections.
* Added packages used only for examples to Suggests section of DESCRIPTION
* Modified examples using packages in Suggests section of DESCRIPTION to only 
  run if the package is available.
  
Note: The examples for fredr_tags() and fredr_tags_series() take greater than 5s
due to the response time from the FRED API itself.  No modifications to the R code
or changes to parameters such as 'limit' seem to be able to increase this response
time.

## Previous resubmissions

* Modified the contents of LICENSE such that it adheres to the CRAN template for
  the MIT license.
* Verified the Title section of DESCRIPTION is now in title case.
* Reworded the Description section of DESCRIPTION to remove redundancies.
* Added single quotes to mentions of 'FRED' and 'Federal Reserve Economic Data'.
* Added the FRED API URL to the Description section of DESCRIPTION.

## Release Summary

This is the first release of 'fredr'. 'fredr' provides a complete R interface
to the FRED (Federal Reserve of Economic Data, St. Louis) API.

Notes to CRAN: We understand that generally examples should not be wrapped in
\dontrun{}. However, all examples wrapped in \dontrun{} require API
authentication and would fail on CRAN. We test extensively on Travis and 
Appveyor. The 'riingo' package does a similar thing, and its author is a
co-author here.

https://github.com/sboysel/fredr/tree/master/tests/testthat
https://travis-ci.org/sboysel/fredr
https://ci.appveyor.com/project/sboysel/fredr/branch/master
