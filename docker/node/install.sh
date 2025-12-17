#!/bin/bash
set -e

# install packages
PACKAGES=(
  bun-bin
  nvm
  pnpm
  pnpm-shell-completion
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"
su - dev -s /bin/zsh -c '
  export NVM_DIR="$HOME/.nvm"
  source /usr/share/nvm/init-nvm.sh
  nvm install --lts
'
