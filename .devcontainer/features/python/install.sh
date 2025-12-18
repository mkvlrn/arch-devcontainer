#!/bin/bash
set -e

# install packages
PACKAGES=(
  uv
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"

# copy files
cp *.zsh /home/dev/.config/zsh/
chown dev:dev /home/dev/.config/zsh/*.zsh
