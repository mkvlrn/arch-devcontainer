#!/bin/bash
set -e

# install packages
PACKAGES=(
  go
)
su dev -c "yay -S --needed --noconfirm ${PACKAGES[*]}"
su - dev -s /bin/zsh -c '
  go install golang.org/x/tools/gopls@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install github.com/haya14busa/goplay/cmd/goplay@latest
  go install github.com/josharian/impl@latest
  go install github.com/cweill/gotests/gotests@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install mvdan.cc/gofumpt@latest
'

# copy files
cp *.zsh /home/dev/.config/zsh/
chown dev:dev /home/dev/.config/zsh/*.zsh
