MKFILE_DIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))

# Make Terraform Documentation
.PHONY: docs
docs:
ifdef OS
	powershell -ExecutionPolicy Bypass -Command "ForEach ($$directory in ('.')) { terraform-docs markdown table --output-file README.md --output-mode inject $$directory }"
else
	for directory in .; do \
	  terraform-docs markdown table --output-file README.md --output-mode inject "$${directory}" ; \
	done
endif

.PHONY: format
format:
	terraform fmt -recursive && cd ..

.PHONY: fixcommit
fixcommit:
	pre-commit run --all-files

.PHONY: diagram
diagram:
	python diagram.py

.PHONY: tflint
tflint:
	tflint --recursive
