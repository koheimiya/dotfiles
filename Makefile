SHELL=/bin/bash
DOCKER_COMPOSE=DOCKER_UID=$$(id -u) DOCKER_GID=$$(id -g) docker compose
.PHONY: build shell

build:
	$(DOCKER_COMPOSE) build

shell:
	$(DOCKER_COMPOSE) run --rm dotfile_test /bin/bash -i
