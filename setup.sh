#!/bin/sh

ORG="mkvlrn"
REPO="arch-devcontainer"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$ORG/$REPO/$BRANCH"

VARIANT="$1"
if [ -z "$VARIANT" ]; then
    echo "Usage: $0 <variant>" >&2
    echo "Example: curl -sL ...setup.sh | bash -s -- node" >&2
    exit 1
fi

echo "Starting DevContainer setup ($VARIANT) from $ORG/$REPO/$BRANCH..."
mkdir -p .devcontainer
echo "Created .devcontainer directory."
echo "Fetching configuration files..."
curl -sfL "$BASE_URL/.devcontainer/devcontainer-$VARIANT.json" -o .devcontainer/devcontainer.json || {
    echo "Error: variant '$VARIANT' not found" >&2
    rm -rf .devcontainer
    exit 1
}
curl -sfL "$BASE_URL/.devcontainer/.gitignore" -o .devcontainer/.gitignore
curl -sfL "$BASE_URL/.devcontainer/.env.devcontainer.example" -o .devcontainer/.env.devcontainer.example
curl -sfL "$BASE_URL/.devcontainer/devpod.sh" -o .devcontainer/devpod.sh
chmod +x .devcontainer/devpod.sh
echo "Setup complete ($VARIANT). Run ./.devcontainer/devpod.sh to start the workspace."
