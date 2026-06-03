.PHONY: up up-build down restart restart-build logs purge

COMMIT ?= $(shell git -C echo rev-parse HEAD)
COMMIT_TIME ?= $(shell git -C echo show -s --format=%cI HEAD)
BUILD_ARGS := --build-arg COMMIT=$(COMMIT) --build-arg COMMIT_TIME=$(COMMIT_TIME)

up:
	docker compose up -d

up-build:
	docker compose build $(BUILD_ARGS) echo
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

restart-build:
	docker compose build $(BUILD_ARGS) echo
	docker compose up -d --force-recreate

logs:
	docker compose logs -f

purge:
	docker compose down --volumes --remove-orphans
