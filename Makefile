R=/usr/bin/rscript

all: knit

knit: README.Rmd
	R -e "packrat::with_extlib('knitr', knit('README.Rmd'))"
