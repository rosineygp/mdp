.EXPORT_ALL_VARIABLES:
.ONESHELL:
SHELL = /bin/bash

define . =
	source .mkdkr
	$(eval MKDKR_JOB_NAME=$(shell bash -c 'source .mkdkr; .... $(@)'))
	trap '.' EXIT
endef

test_a:
	@$(.)
	... alpine
	.. echo "test $(@)"

test_b:
	@$(.)
	... alpine
	.. echo "test $(@)"

test_c:
	@$(.)
	... alpine
	.. echo "test $(@)"

build:
	@$(.)
	... alpine
	.. echo "build $(@)"

pack:
	@$(.)
	... alpine
	.. echo "pack $(@)"

deploy:
	@$(.)
	... alpine
	.. echo "stage: $(@)"

test: test_a test_b test_c

pipeline:
	make -f pipeline.mk test -j 3 --output-sync
	make -f pipeline.mk build
	make -f pipeline.mk pack
	make -f pipeline.mk deploy