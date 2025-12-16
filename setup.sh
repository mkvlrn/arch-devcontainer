#!/bin/sh

# Configuration (These variables must be hardcoded inside this remote script)
ORG="mkvlrn"
REPO="arch-devcontainer"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$ORG/$REPO/$BRANCH"

echo "Starting DevContainer setup from $ORG/$REPO/$BRANCH..."

# 1. Create .devcontainer directory
mkdir -p .devcontainer
echo "Created .devcontainer directory."

# 2. Fetch .devcontainer
echo "Fetching configuration files..."
curl -o .devcontainer/devcontainer.json -L "$BASE_URL/.devcontainer/devcontainer.json"
curl -o .devcontainer/.gitignore -L "$BASE_URL/.devcontainer/.gitignore"
curl -o .devcontainer/.env.devcontainer.example -L "$BASE_URL/.devcontainer/.env.devcontainer.example"
curl -o .devcontainer/devpod.sh -L "$BASE_URL/.devcontaienr/devpod.sh"

# 3. Make the launch script executable
echo "Setting executable permission for devpod.sh..."
chmod +x .devcontainer/devpod.sh

echo "Setup complete. Run ./.devcontainer/devpod.sh to start the workspace."
