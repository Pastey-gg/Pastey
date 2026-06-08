.PHONY: up up-build up-build-echo up-build-oriana down restart logs purge

PASTEY_VERSION ?= $(shell sed -n '1p' VERSION)

ECHO_COMMIT ?= $(shell git -C echo rev-parse HEAD)
ECHO_COMMIT_TIME ?= $(shell git -C echo show -s --format=%cI HEAD)
ECHO_VERSION ?= $(shell sed -n '1p' echo/VERSION)
ECHO_BUILD_ARGS := --build-arg COMMIT=$(ECHO_COMMIT) --build-arg COMMIT_TIME=$(ECHO_COMMIT_TIME)

ORIANA_COMMIT ?= $(shell git -C oriana rev-parse HEAD)
ORIANA_COMMIT_TIME ?= $(shell git -C oriana show -s --format=%cI HEAD)
ORIANA_VERSION ?= $(shell sed -n '1p' oriana/VERSION)
ORIANA_BUILD_ARGS := --build-arg PASTEY_VERSION=$(PASTEY_VERSION) --build-arg ORIANA_VERSION=$(ORIANA_VERSION) --build-arg COMMIT=$(ORIANA_COMMIT) --build-arg COMMIT_TIME=$(ORIANA_COMMIT_TIME)

up:
	docker compose up -d

up-build:
	docker compose build $(ECHO_BUILD_ARGS) echo
	docker compose build $(ORIANA_BUILD_ARGS) oriana
	docker compose up -d echo oriana

up-build-echo:
	docker compose build $(ECHO_BUILD_ARGS) echo
	docker compose up -d --no-deps echo

up-build-oriana:
	docker compose build $(ORIANA_BUILD_ARGS) oriana
	docker compose up -d --no-deps oriana

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

purge:
	docker compose down --volumes --remove-orphans
