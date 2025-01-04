.PHONY: all dats plots clean-dats clean-plots clean-all

# run everything
all : report/count_report.html

# count the words
dats: results/isles.dat \
	results/abyss.dat \
	results/last.dat \
	results/sierra.dat

results/isles.dat : data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat : data/abyss.txt
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat : data/last.txt
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: data/sierra.txt
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat

# create the plots
plots : results/figure/isles.png \
		results/figure/abyss.png \
		results/figure/last.png \
		results/figure/sierra.png

results/figure/isles.png: results/isles.dat 
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat 
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat 
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat 
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png

# write the report
report/count_report.html: report/count_report.qmd plots
	quarto render report/count_report.qmd

clean-dats:
	rm -f results/isles.dat \
		results/abyss.dat \
		results/last.dat \
		results/sierra.dat

clean-plots: 
	rm -f results/figure/isles.png \
		results/figure/abyss.png \
		results/figure/last.png \
		results/figure/sierra.png

clean-all: clean-dats \
	clean-plots
	rm -f report/count_report.html
	rm -rf report/count_report_files 
	