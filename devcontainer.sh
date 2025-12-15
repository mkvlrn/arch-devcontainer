#!/bin/sh

ENV_FILE="./.devcontainer/.env.devcontainer"
RECREATE_FLAG=""

# Check for --recreate argument
if [[ "$1" == "--recreate" ]]; then
    RECREATE_FLAG="--recreate"
fi

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: Environment file '$ENV_FILE' not found." >&2
    exit 1
fi

source_command=$(grep -v '^#' "$ENV_FILE" | xargs -I {} echo "export {}")
eval "$source_command"

devpod-cli context set-options default -o SSH_INJECT_GIT_CREDENTIALS=false
devpod-cli up . --ide "$PROJECT_EDITOR" \
    --workspace-env-file "$ENV_FILE" \
    "$RECREATE_FLAG"
