#!/bin/bash
set -e

DOCKERFILE_PATH="docker/Dockerfile"
CONTEXT_PATH="docker"
IMAGE_BASE="mkvlrn/arch-devcontainer"
CALVER="$(date +%Y.%m.%d-%H%M%S)"
NOCACHE_FLAG=""

if [ "$1" = "--no-cache" ]; then
    NOCACHE_FLAG="--no-cache"
fi

docker build \
    $NOCACHE_FLAG \
    -t "${IMAGE_BASE}:${CALVER}" \
    -t "${IMAGE_BASE}:latest" \
    -f "$DOCKERFILE_PATH" \
    "$CONTEXT_PATH"
