#!/bin/bash
set -e

IMAGE_NAME="ghcr.io/mkvlrn/arch-devcontainer"
CALVER="$(date +%Y.%m.%d-%H%M%S)"

# parse arguments
NOCACHE_FLAG=""
CACHE_FLAGS=""
PUSH_FLAG=""
for arg in "$@"; do
    case "$arg" in
    --no-cache) NOCACHE_FLAG="--no-cache" ;;
    --push)
        PUSH_FLAG="--push"
        CACHE_FLAGS="--cache-from type=registry,ref=${IMAGE_NAME}:buildcache --cache-to type=registry,ref=${IMAGE_NAME}:buildcache,mode=max"
        ;;
    esac
done

# build
echo "==> Building image..."
docker buildx build \
    $NOCACHE_FLAG \
    $CACHE_FLAGS \
    $PUSH_FLAG \
    -t "${IMAGE_NAME}:${CALVER}" \
    -t "${IMAGE_NAME}:latest" \
    -f docker/Dockerfile \
    docker

# cleanup old tags and prune
docker images "$IMAGE_NAME" --format '{{.Repository}}:{{.Tag}}' |
    grep -v -E ":(latest|$CALVER)$" |
    xargs -r docker rmi --force 2>/dev/null || true
docker image prune -f 2>/dev/null || true
echo "==> Done!"
