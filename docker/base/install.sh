#!/bin/bash
set -e

# update makepkg.conf
sed -i '/^OPTIONS=/d;/^MAKEFLAGS=/d' /etc/makepkg.conf
cat <<'EOF' >>/etc/makepkg.conf
OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)
MAKEFLAGS="--jobs=$(nproc)"
EOF

# update system, install initial packages
pacman -Syu --noconfirm
pacman -S --needed --noconfirm base-devel git reflector sudo zsh

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
reflector --latest 20 --protocol https --sort rate --country Brazil --save /etc/pacman.d/mirrorlist
pacman -Syy --noconfirm

# base packages
PACKAGES=(
  aws-cli-bin
  fastfetch
  github-cli
  htop
  jq
  k-git
  less
  oh-my-posh-bin
  zsh-autocomplete-git
  zsh-syntax-highlighting-git
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"
