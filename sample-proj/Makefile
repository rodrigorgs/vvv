all: data/c-female data/c-male data/d-female data/d-male data/e report/fork-female.html report/fork-male.html report/join.html report/pipe-female.html report/pipe-male.html

clean:
	rm -f data/c-female data/c-male data/d-female data/d-male data/e report/fork-female.html report/fork-male.html report/join.html report/pipe-female.html report/pipe-male.html

data/c-female: data/b script/fork-female.R
	./run-script.rb script/fork-female.R

report/fork-female.html: data/b script/fork-female.R
	./run-script.rb script/fork-female.R

data/c-male: data/b script/fork-male.R
	./run-script.rb script/fork-male.R

report/fork-male.html: data/b script/fork-male.R
	./run-script.rb script/fork-male.R

data/e: data/d-male data/d-female script/join.R
	./run-script.rb script/join.R

report/join.html: data/d-male data/d-female script/join.R
	./run-script.rb script/join.R

data/d-female: data/c-female script/pipe-female.R
	./run-script.rb script/pipe-female.R

report/pipe-female.html: data/c-female script/pipe-female.R
	./run-script.rb script/pipe-female.R

data/d-male: data/c-male script/pipe-male.R
	./run-script.rb script/pipe-male.R

report/pipe-male.html: data/c-male script/pipe-male.R
	./run-script.rb script/pipe-male.R
