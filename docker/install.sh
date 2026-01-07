#!/bin/bash
set -e

: "${TZ:=America/Sao_Paulo}"
export TZ

# update makepkg.conf
sed -i '/^OPTIONS=/d;/^MAKEFLAGS=/d' /etc/makepkg.conf
cat <<'EOF' >>/etc/makepkg.conf
OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)
MAKEFLAGS="--jobs=$(nproc)"
EOF

# update system, install initial packages
pacman -Syu --noconfirm
pacman -S --needed --noconfirm base-devel git sudo tzdata zsh

# timezone
ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime
echo "$TZ" >/etc/timezone

# yay
useradd -m build
git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
chown -R build:build /tmp/yay-bin
su build -c 'cd /tmp/yay-bin && makepkg -s'
pacman -U --noconfirm /tmp/yay-bin/*.pkg.tar.zst
userdel -r build
rm -rf /tmp/yay-bin

# dev user
USERNAME="dev"
USER_UID="1000"
USER_GID="$USER_UID"
groupadd -g "$USER_GID" "$USERNAME"
useradd -m -s /bin/zsh -u "$USER_UID" -g "$USER_GID" "$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >"/etc/sudoers.d/$USERNAME"
chmod 0440 "/etc/sudoers.d/$USERNAME"

# update mirrors
su dev -c "yay -Y --devel --save"
pacman -Syy --noconfirm

# base packages
PACKAGES=(
  aws-cli-bin
  fastfetch
  github-cli
  glab
  go
  htop
  jq
  k-git
  less
  nvm
  oh-my-posh-bin
  openssh
  pnpm-bin
  pnpm-shell-completion
  terraform
  zsh-autocomplete-git
  zsh-syntax-highlighting-git
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"

# latest node via nvm
su - dev -s /bin/zsh -c "
  export NVM_DIR=/home/dev/.nvm
  source /usr/share/nvm/init-nvm.sh
  nvm install --lts
"

# go tools
su - dev -s /bin/zsh -c '
  go install golang.org/x/tools/gopls@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install github.com/haya14busa/goplay/cmd/goplay@latest
  go install github.com/josharian/impl@latest
  go install github.com/cweill/gotests/gotests@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install mvdan.cc/gofumpt@latest
'
