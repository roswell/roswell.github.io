all: update generate

generate:
	./generate.ros
	cp Home.html index.html

update:
	git submodule update --init --recursive

clean:
	rm -rf *~ *.html

distclean: clean
	rm -rf roswell.wiki

.PHONY: distclean clean update
