#!/bin/bash

ENV_FILE="./.devcontainer/.env.devcontainer"
RECREATE_FLAG=""

if [[ "$1" == "--recreate" ]]; then
  RECREATE_FLAG="--recreate"
fi

if command -v devpod-cli >/dev/null 2>&1; then
  DEVPOD_BIN="devpod-cli"
elif command -v devpod >/dev/null 2>&1; then
  DEVPOD_BIN="devpod"
else
  echo "error: devpod binary not found in PATH (expected devpod-cli or devpod)" >&2
  exit 1
fi

if [ ! -x "$(command -v "$DEVPOD_BIN")" ]; then
  echo "error: $DEVPOD_BIN found but not executable" >&2
  exit 1
fi

while IFS='=' read -r key value; do
  [[ -z "$key" || "$key" =~ ^# ]] && continue
  value="${value#\"}"
  value="${value%\"}"
  value="${value#\'}"
  value="${value%\'}"
  export "$key=$value"
done <"$ENV_FILE"

"$DEVPOD_BIN" context set-options default -o SSH_INJECT_GIT_CREDENTIALS=false
CMD=(devpod-cli up . --ide "$PROJECT_EDITOR" --workspace-env-file "$ENV_FILE")
[[ -n "$RECREATE_FLAG" ]] && CMD+=("$RECREATE_FLAG")
"${CMD[@]}"
