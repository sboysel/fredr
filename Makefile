R=/usr/local/bin/R

all: README.md vignettes check docs

README.md: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
	rm -f README.html

vignettes: vignettes/fredr.Rmd
	$(R) -e "devtools::install()"
	$(R) -e "devtools::build_vignettes()"

docs: R/*.R tests/testthat/*.R _pkgdown.yml
	$(R) -e "devtools::document()"
	$(R) -e "pkgdown::build_site()"

check: R/*.R tests/testthat/*.R _pkgdown.yml
	$(R) -e "devtools::check()"

