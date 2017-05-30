R=/usr/local/bin/R

all: knit

knit: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
