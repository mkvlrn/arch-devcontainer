#!/bin/bash
set -e

export GIT_CONFIG_GLOBAL="$HOME/.gitconfig-container"

# load from .env file if it exists
if [ -f ~/.env-local ]; then
    while IFS='=' read -r key value || [ -n "$key" ]; do
        [[ -z "$key" || "$key" =~ ^# ]] && continue
        value="${value#\"}"
        value="${value%\"}"
        export "$key=$value"
    done <~/.env-local
else
    echo "WARNING: .devcontainer/.env not found - using defaults"
    echo "Create .devcontainer/.env with GIT_NAME and GIT_EMAIL"
fi

# set identity from env vars
git config --global user.name "${GIT_NAME:-dev}"
git config --global user.email "${GIT_EMAIL:-dev@dev.com}"

# SSH-only git using mounted key
git config --global core.sshCommand "ssh -i /home/dev/.ssh/mounted_key -o IdentitiesOnly=yes"

# commit signing via mounted SSH key
git config --global commit.gpgsign true
git config --global gpg.format ssh
git config --global user.signingkey /home/dev/.ssh/mounted_key

# other stuff
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.eol lf
git config --global push.followTags true
git config --global pull.rebase false
