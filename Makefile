R=/usr/local/bin/R

all: README.md vignettes check

README.md: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
	rm -f README.html

vignettes: vignettes/fredr.Rmd
	$(R) -e "devtools::build_vignettes()"

check: R/*.R tests/testthat/*.R
	$(R) -e "devtools::document()"
	$(R) -e "pkgdown::build_site()"
	$(R) -e "pkgdown::build_reference(lazy = FALSE)"
	$(R) -e "devtools::check()"


