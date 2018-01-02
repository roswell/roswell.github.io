all: clean update
	git clone https://github.com/roswell/roswell.github.io.git _public
	rm -rf _public/*
	./wiki2html.ros
	cp style.css _public/style.css

.PHONY: update clean upload

upload:
	cd _public && git add * && git commit -m 'update documents' && git push -f

update:
	git submodule update --init
	git submodule update --remote

clean:
	rm -rf _public *~
