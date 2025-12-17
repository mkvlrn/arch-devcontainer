#!/bin/bash
set -e

# install packages
PACKAGES=(
  uv
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"
