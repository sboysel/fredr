R=/usr/local/bin/R

all: README.md check

README.md: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
	$(R) -e "devtools::document()"
	$(R) -e "pkgdown::build_site()"
	$(R) -e "pkgdown::build_reference(lazy = FALSE)"
	rm -f README.html

check:
	$(R) -e "devtools::check(build_args = c('--no-build-vignettes'))"


