.PHONY: up up-build up-build-echo up-build-oriana down restart logs purge

COMMIT ?= $(shell git -C echo rev-parse HEAD)
COMMIT_TIME ?= $(shell git -C echo show -s --format=%cI HEAD)
BUILD_ARGS := --build-arg COMMIT=$(COMMIT) --build-arg COMMIT_TIME=$(COMMIT_TIME)

up:
	docker compose up -d

up-build:
	docker compose build $(BUILD_ARGS) echo
	docker compose build oriana
	docker compose up -d echo oriana

up-build-echo:
	docker compose build $(BUILD_ARGS) echo
	docker compose up -d --no-deps echo

up-build-oriana:
	docker compose build oriana
	docker compose up -d --no-deps oriana

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

purge:
	docker compose down --volumes --remove-orphans
