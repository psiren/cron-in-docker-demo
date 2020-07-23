# BEST PRACTICES
# * See https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

-include ./Makefile*.mk


## APP

DIR_NAME := $(shell basename $(CURDIR))
VERSION := 0.0.1
PROJECT_NAME := $(DIR_NAME)
DOCKER_IMAGE_TAG := $(PROJECT_NAME):$(VERSION)

## Build the application in the docker image
build: docker/build
.PHONY: build

## Run applciation in the background
service: docker/run-service
.PHONY: service

## Stop the application
stop: docker/container-stop
.PHONY: stop

## Run applciation in the foreground
up: docker/run
.PHONY: up

## Stops and resets the application
clean: docker/clean
.PHONY: clean

## Attach to the running instance
attach: docker/attach
.PHONY: attach

## Shell into the running instance
sh: docker/sh
.PHONY: attach


## DOCKER

docker/clean: docker/container-stop docker/container-remove docker/remove-image
.PHONY: clean

docker/build:
	docker build --rm --tag $(DOCKER_IMAGE_TAG) .
.PHONY: docker/build

docker/run:
	docker run --rm --interactive --tty --name $(PROJECT_NAME) $(DOCKER_IMAGE_TAG)
.PHONY: docker/run

docker/run-service:
	docker run --detach --interactive --tty --name $(PROJECT_NAME) $(DOCKER_IMAGE_TAG)
.PHONY: docker/run

docker/container-stop:
	-docker stop --time 1 $(PROJECT_NAME)
.PHONY: docker/container-stop

docker/container-remove:
	-docker rm $(DOCKER_IMAGE_TAG)
.PHONY: docker/container-remove

docker/remove-image:
	-docker rmi $(DOCKER_IMAGE_TAG)
.PHONY: docker/remove-image

docker/crond:
	docker run --rm --interactive --tty --name $(PROJECT_NAME) $(DOCKER_IMAGE_TAG) crond
.PHONY: docker/crond

docker/sh:
	docker exec --interactive --tty $(PROJECT_NAME) sh
.PHONY: docker/sh

docker/attach:
	docker attach $(PROJECT_NAME)
.PHONY: docker/attach
