all: update generate commit push

.PHONY: update generate commit push

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
