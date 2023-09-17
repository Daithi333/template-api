$DOCKER_IMAGE_FILE = "./docker/Dockerfile"
$DOCKER_IMAGE_REPO = "ghcr.io/daithi333"
$DOCKER_IMAGE_NAME = "template"
$DOCKER_IMAGE_TAG = "latest"
$DOCKER_IMAGE_CONTEXT = "."

function help {
    Get-Content $PSCommandPath | ForEach-Object {
        if ($_ -match "## (.+)$") {
            Write-Host $matches[1]
        }
    }
}

function docker.build {
    docker build -f ${DOCKER_IMAGE_FILE} -t "${DOCKER_IMAGE_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" ${DOCKER_IMAGE_CONTEXT}
}

function docker.shell {
    docker run --rm -it `
        -v "${PWD}/src:/opt/app-root/src" `
        -v "${PWD}/Pipfile:/opt/app-root/Pipfile" `
        -v "${PWD}/docker/cmds/start_server.sh:/opt/app-root/start_server.sh" `
        "${DOCKER_IMAGE_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" /bin/sh
}

function run {
    $ADDITIONAL_ARGS = "--env-file ./.env"
    docker run --rm -it `
        -u 0 `
        -p "0.0.0.0:8080:8080" `
        -v "${PWD}/src:/opt/app-root/src" `
        -v "${PWD}/docker/cmds/start_server.sh:/opt/app-root/start_server.sh" `
        $ADDITIONAL_ARGS `
        "${DOCKER_IMAGE_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
}

function run.background {
    $ADDITIONAL_ARGS = "--env-file ./.env --name $DOCKER_IMAGE_NAME --network template-network"
    docker run -it `
        -u 0 `
        -p "0.0.0.0:8080:8080" `
        $ADDITIONAL_ARGS `
        "${DOCKER_IMAGE_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
}

### Usage
# Load the functions from the script to your session
# . .\dockerCommands.ps1

# Run the desired function
# docker.build
