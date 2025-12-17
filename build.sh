#!/bin/bash
set -e

IMAGE_BASE="mkvlrn/arch-devcontainer"
DOCKER_DIR="docker"
CALVER="$(date +%Y.%m.%d-%H%M%S)"
TARGETS=()

NOCACHE_FLAG=""
PUSH=false

# parse arguments
for arg in "$@"; do
    case "$arg" in
    --no-cache) NOCACHE_FLAG="--no-cache" ;;
    --push) PUSH=true ;;
    *) TARGETS+=("$arg") ;;
    esac
done

# if no targets specified, build all variants (skip base)
if [ ${#TARGETS[@]} -eq 0 ]; then
    for dir in "$DOCKER_DIR"/*/; do
        name=$(basename "$dir")
        [[ "$name" == "base" ]] && continue
        TARGETS+=("$name")
    done
fi

for variant in "${TARGETS[@]}"; do
    [[ "$variant" == "base" ]] && continue
    if [ ! -d "$DOCKER_DIR/$variant" ]; then
        echo "Warning: $variant not found, skipping..."
        continue
    fi

    IMAGE_NAME="${IMAGE_BASE}-${variant}"
    echo "==> Building $variant..."

    docker build \
        $NOCACHE_FLAG \
        -t "${IMAGE_NAME}:${CALVER}" \
        -t "${IMAGE_NAME}:latest" \
        -f "$DOCKER_DIR/Dockerfile" \
        --build-arg VARIANT="$variant" \
        "$DOCKER_DIR"

    # cleanup old tags
    docker images "$IMAGE_NAME" --format '{{.Repository}}:{{.Tag}}' |
        grep -v -E ":(latest|$CALVER)$" |
        xargs -r docker rmi --force 2>/dev/null || true

    if $PUSH; then
        echo "==> Pushing $variant..."
        docker push "${IMAGE_NAME}:${CALVER}"
        docker push "${IMAGE_NAME}:latest"
    fi
done

docker image prune -f 2>/dev/null || true
echo "==> Done!"
