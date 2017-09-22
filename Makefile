all: update clean generate commit push

.PHONY: update clean generate commit push

generate:
	./generate.ros
	cp Home.html index.html

update:
	git submodule update --init
	git submodule update --remote

push:
	git push

commit:
	git commit -am 'Update documents'

clean:
	rm -f *.html
