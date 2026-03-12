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
pacman -S --needed --noconfirm base-devel git sudo tzdata fish

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
useradd -m -s /bin/fish -u "$USER_UID" -g "$USER_GID" "$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >"/etc/sudoers.d/$USERNAME"
chmod 0440 "/etc/sudoers.d/$USERNAME"

# copy .config over
cp -r /tmp/.config /home/dev/.config
mkdir -p /home/dev/.config/fish/completions
chown -R dev:dev /home/dev/.config

# update mirrors
su dev -c "yay -Y --devel --save"
pacman -Syy --noconfirm

# base packages
PACKAGES=(
  docker
  docker-buildx
  docker-compose
  eza
  fastfetch
  fish
  htop
  less
  oh-my-posh-bin
  openssh
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"

# dev packages with mise
su -l dev -c "curl https://mise.run | sh && PATH=\"/home/dev/.local/bin:\$PATH\" /home/dev/.local/bin/mise install"

# fish completions
su dev -c "glab completion -s fish >~/.config/fish/completions/glab.fish"
su dev -c "mise completion fish >~/.config/fish/completions/mise.fish"
su dev -c "pnpm completion fish >~/.config/fish/completions/pnpm.fish"
su dev -c "gh completion -s fish >~/.config/fish/completions/gh.fish"

# cleanup
pacman -Scc --noconfirm
su dev -c "yay -Scc --noconfirm"
rm -rf /var/cache/pacman/pkg/* /home/dev/.cache /tmp/*
