.PHONY: up up-build down restart restart-build logs purge

up:
	docker compose up -d

up-build:
	docker compose up --build -d

down:
	docker compose down

restart:
	docker compose restart

restart-build:
	docker compose up --build -d --force-recreate

logs:
	docker compose logs -f

purge:
	docker compose down --volumes --remove-orphans
