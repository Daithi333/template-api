DOCKER_IMAGE_FILE=./docker/Dockerfile
DOCKER_IMAGE_REPO=https://ghcr.io/Daithi333
DOCKER_IMAGE_NAME=template
DOCKER_IMAGE_TAG=latest
DOCKER_IMAGE_CONTEXT=.

.PHONY: help
help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

docker.build:
	docker build \
		-f $(DOCKER_IMAGE_FILE) \
		-t $(DOCKER_IMAGE_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) $(DOCKER_IMAGE_CONTEXT)

docker.shell:
	docker run --rm -it \
		-v ${PWD}/src:/opt/app-root/src \
		-v ${PWD}/Pipfile:/opt/app-root/Pipfile \
		-v ${PWD}/docker/cmds/start_server.sh:/opt/app-root/start_server.sh \
		$(DOCKER_IMAGE_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) /bin/sh

run: ADDITIONAL_ARGS = --env-file ./.env
run:
	docker run \
	--rm \
	-it \
	-u 0 \
	-p 0.0.0.0:8080:8080 \
	-v ${PWD}/src:/opt/app-root/src \
	-v ${PWD}/docker/cmds/start_server.sh:/opt/app-root/start_server.sh \
	$(ADDITIONAL_ARGS) \
	$(DOCKER_IMAGE_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

run.background: ADDITIONAL_ARGS = --env-file ./.env --name $(DOCKER_IMAGE_NAME) --network template-network
run.background:
	docker run \
	-it \
	-u 0 \
	-p 0.0.0.0:8080:8080 \
	$(ADDITIONAL_ARGS) \
	$(DOCKER_IMAGE_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
