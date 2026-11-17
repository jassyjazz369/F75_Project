
.PHONY: all male female clean

all:
	Rscript -e 'rmarkdown::render("report.Rmd", output_file="report_all.html", output_dir="output", params=list(sex="all"))'

male:
	Rscript -e 'rmarkdown::render("report.Rmd", output_file="report_male.html", output_dir="output", params=list(sex="male"))'

female:
	Rscript -e 'rmarkdown::render("report.Rmd", output_file="report_female.html", output_dir="output", params=list(sex="female"))'

clean:
	Rscript -e 'unlink(list.files("output", pattern="^report_.*[.]html$", full.names=TRUE))'
