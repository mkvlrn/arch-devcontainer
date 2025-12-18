#!/bin/bash

ENV_FILE="./.devcontainer/.env.devcontainer"
RECREATE_FLAG=""

if [[ "$1" == "--recreate" ]]; then
  RECREATE_FLAG="--recreate"
fi

command -v devpod-cli >/dev/null 2>&1 && [ -x "$(command -v devpod-cli)" ] ||
  {
    echo "error: devpod-cli not found or not executable in PATH" >&2
    exit 1
  }

if [ ! -f "$ENV_FILE" ]; then
  echo "error: environment file '$ENV_FILE' not found." >&2
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

devpod-cli context set-options default -o SSH_INJECT_GIT_CREDENTIALS=false
CMD=(devpod-cli up . --ide "$PROJECT_EDITOR" --workspace-env-file "$ENV_FILE")
[[ -n "$RECREATE_FLAG" ]] && CMD+=("$RECREATE_FLAG")
"${CMD[@]}"
