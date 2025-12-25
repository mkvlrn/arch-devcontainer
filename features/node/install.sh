#!/bin/bash
set -e

# install packages
PACKAGES=(
  nvm
  pnpm-bin
  pnpm-shell-completion
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"
su - dev -s /bin/zsh -c "
  export NVM_DIR=/home/dev/.nvm
  source /usr/share/nvm/init-nvm.sh
  nvm install ${NODEVERSION:-24}
"

# copy files
cp *.zsh /home/dev/.config/zsh/
chown dev:dev /home/dev/.config/zsh/*.zsh
