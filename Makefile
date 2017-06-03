R=/usr/local/bin/R

all: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
	$(R) -e "devtools::document()"
	$(R) -e "pkgdown::build_site()"
	$(R) -e "devtools::check()"
	rm README.html

