#!/bin/sh

ORG="mkvlrn"
REPO="arch-devcontainer"
TARBALL_URL="https://github.com/$ORG/$REPO/archive/refs/heads/main.tar.gz"

echo "Starting DevContainer setup from $ORG/$REPO..."
curl -sfL "$TARBALL_URL" | tar -xz --strip-components=1 "$REPO-main/.devcontainer"
rm -f .devcontainer/.env.devcontainer
chmod +x .devcontainer/devpod.sh
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Copy .devcontainer/.env.devcontainer.example to .devcontainer/.env.devcontainer"
echo "  2. Edit .devcontainer/.env.devcontainer with your settings"
echo "  3. Edit .devcontainer/devcontainer.json to add features you need"
echo "  4. Run ./.devcontainer/devpod.sh to start"
