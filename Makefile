DOCKER_COMPOSE=DOCKER_UID=$$(id -u) DOCKER_GID=$$(id -g) docker compose
SHELL=$${SHELL}
.PHONY: install build shell

install:
	$(SHELL) -i ./install_home.bash
	$(SHELL) -i ./install_super.bash

build:
	$(DOCKER_COMPOSE) build

shell:
	$(DOCKER_COMPOSE) run --rm dotfile_test /bin/bash -i
