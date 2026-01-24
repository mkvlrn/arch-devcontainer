#!/bin/bash
set -e

# fix docker socket permissions if mounted
SOCKET=/var/run/docker.sock
if [ -S "$SOCKET" ]; then
    SOCKET_GID=$(stat -c '%g' "$SOCKET")
    if ! getent group docker >/dev/null; then
        sudo groupadd -g "$SOCKET_GID" docker
    else
        sudo groupmod -g "$SOCKET_GID" docker
    fi
    sudo usermod -aG docker dev
fi

exec "$@"
