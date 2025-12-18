#!/bin/bash
set -e

IMAGE_NAME="mkvlrn/arch-devcontainer"
DOCKER_DIR="docker"
CALVER="$(date +%Y.%m.%d-%H%M%S)"

# parse arguments
NOCACHE_FLAG=""
PUSH=false
for arg in "$@"; do
    case "$arg" in
    --no-cache) NOCACHE_FLAG="--no-cache" ;;
    --push) PUSH=true ;;
    esac
done

echo "==> Building image..."

docker build \
    $NOCACHE_FLAG \
    -t "${IMAGE_NAME}:${CALVER}" \
    -t "${IMAGE_NAME}:latest" \
    -f "$DOCKER_DIR/Dockerfile" \
    "$DOCKER_DIR"

# cleanup old tags
docker images "$IMAGE_NAME" --format '{{.Repository}}:{{.Tag}}' |
    grep -v -E ":(latest|$CALVER)$" |
    xargs -r docker rmi --force 2>/dev/null || true

if $PUSH; then
    echo "==> Pushing to Docker Hub..."
    docker push "${IMAGE_NAME}:${CALVER}"
    docker push "${IMAGE_NAME}:latest"
fi

docker image prune -f 2>/dev/null || true
echo "==> Done!"
