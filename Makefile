all: update generate

generate:
	./generate.ros
	cp Home.html index.html

update: roswell.wiki
	git submodule update

clean:
	rm -rf *~ *.html

distclean: clean
	rm -rf roswell.wiki

.PHONY: distclean clean update
