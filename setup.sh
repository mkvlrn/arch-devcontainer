#!/bin/sh

ORG="mkvlrn"
REPO="arch-devcontainer"
TARBALL_URL="https://github.com/$ORG/$REPO/archive/refs/heads/main.tar.gz"

echo "Starting DevContainer setup from $ORG/$REPO..."
curl -sfL "$TARBALL_URL" | tar -xz --strip-components=1 "$REPO-main/.devcontainer" "$REPO-main/docker-compose.yml" "$REPO-main/devpod.sh"
chmod +x ./devpod.sh
cat >.devcontainer/.env <<'EOF'
GIT_NAME=dev
GIT_EMAIL=dev@dev.com
EOF
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .devcontainer/.env with your git identity"
echo "  2. Edit .devcontainer/devcontainer.json to add features you need"
echo "  3. For DevPod: run ./devpod.sh"
echo "  4. For VS Code: Reopen folder in Container (Ctrl+Shift+P)"
