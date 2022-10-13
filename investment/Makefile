.PHONY: all help build run docker-build docker-run

all: help

help:
	@echo "run 'make build' and than 'make run'"

CONDA_ENV_NAME := investment

SHELL=/bin/bash
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate


.ONESHELL:
setup-dev-env:
	conda env create -f conda_dev_environment.yml
	($(CONDA_ACTIVATE) $(CONDA_ENV_NAME) ; pip install -r requirements.dev.txt)

local-run-test:
	@($(CONDA_ACTIVATE) $(CONDA_ENV_NAME) ; python -m pytest --cov )

local-run-test-watch:
	@($(CONDA_ACTIVATE) $(CONDA_ENV_NAME) ; ptw )

clean:
	rm -rf dist
	rm -rf *.egg-info
	rm -rf build

