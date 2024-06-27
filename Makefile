DOCKER_COMPOSE=DOCKER_UID=$$(id -u) DOCKER_GID=$$(id -g) docker compose
.PHONY: install build shell

install:
	./install_home.bash
	./install_super.bash

build:
	$(DOCKER_COMPOSE) build

shell:
	$(DOCKER_COMPOSE) run --rm dotfile_test /bin/bash -i
