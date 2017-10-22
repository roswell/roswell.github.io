all: update clean generate commit push

.PHONY: update clean generate commit push

generate:
	qlot exec ./generate.ros
	mv wiki/Home.html wiki/index.html

update:
	git submodule update --init
	git submodule update --remote

push:
	git push

commit:
	git commit -am 'Update documents'

clean:
	rm -f wiki/*.html
