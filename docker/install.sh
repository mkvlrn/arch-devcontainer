#!/bin/sh

set -e

# update makepkg.conf
sed -i '/^OPTIONS=/d;/^MAKEFLAGS=/d' /etc/makepkg.conf
cat <<'EOF' >>/etc/makepkg.conf
OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)
MAKEFLAGS="--jobs=$(nproc)"
EOF

# update
pacman -Syu --noconfirm

# base
pacman -S --needed --noconfirm base-devel git reflector sudo zsh

# yay
useradd -m build
git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
chown -R build:build /tmp/yay-bin
su build -c '
  cd /tmp/yay-bin
  makepkg -s
'
pacman -U --noconfirm /tmp/yay-bin/*.pkg.tar.zst
userdel -r build
rm -rf /tmp/yay-bin

# user
USERNAME="dev"
USER_UID="1000"
USER_GID="$USER_UID"
groupadd -g "$USER_GID" "$USERNAME"
useradd -m -s /bin/zsh -u "$USER_UID" -g "$USER_GID" "$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >"/etc/sudoers.d/$USERNAME"
chmod 0440 "/etc/sudoers.d/$USERNAME"

# packages yo
PACKAGES="aws-cli-bin bun-bin fastfetch github-cli htop jq k-git less nvm oh-my-posh-bin pnpm pnpm-shell-completion zsh-autocomplete-git zsh-syntax-highlighting-git"
su dev -c "yay -Y --devel --save"
reflector --latest 20 --protocol https --sort rate --country Brazil --save /etc/pacman.d/mirrorlist
pacman -Syy --noconfirm
su dev -c "yay -S --needed --noconfirm $PACKAGES"
su - dev -s /bin/zsh -c '
  export NVM_DIR="$HOME/.nvm"
  source /usr/share/nvm/init-nvm.sh
  nvm install --lts
'

# remove deps and cache
pacman -Scc --noconfirm
su dev -c "yay -Scc --noconfirm"
rm -rf /var/cache/pacman/pkg/*
rm -rf /home/$USERNAME/.cache/yay/*
rm -rf /tmp/*
