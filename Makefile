R=/usr/bin/R

all: knit

knit: README.Rmd
	$(R) -e "knitr::knit('README.Rmd')"
