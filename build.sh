#!/bin/bash
set -e

DOCKERFILE_PATH="docker/Dockerfile"
CONTEXT_PATH="docker"
IMAGE_BASE="mkvlrn/arch-devcontainer"
CALVER="$(date +%Y.%m.%d-%H%M%S)"

NOCACHE_FLAG=""
PUSH=false

for arg in "$@"; do
    case "$arg" in
    --no-cache) NOCACHE_FLAG="--no-cache" ;;
    --push) PUSH=true ;;
    esac
done

docker build \
    $NOCACHE_FLAG \
    -t "${IMAGE_BASE}:${CALVER}" \
    -t "${IMAGE_BASE}:latest" \
    -f "$DOCKERFILE_PATH" \
    "$CONTEXT_PATH"

docker images "$IMAGE_BASE" --format '{{.Repository}}:{{.Tag}} {{.ID}}' |
    awk '$1 !~ /:(latest|'$CALVER')$/ {print $1}' |
    xargs -r docker rmi --force

if $PUSH; then
    docker push "${IMAGE_BASE}:${CALVER}"
    docker push "${IMAGE_BASE}:latest"
fi
