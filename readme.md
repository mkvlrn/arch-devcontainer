# arch-devcontainer

## what is this

a devcontainer setup using arch linux as base image with tools for:

- node
- go
- python
- dotnet

## requirements

- docker
- a linux-like shell (git-bash is good enough on windows)
- an ssh key for git operations ([how to create one](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent))
  - if your key isn't `~/.ssh/id_ed25519`, update the path in `.devcontainer/devcontainer.json`
- one of:
  1. [devpod](https://devpod.sh/) - better than vscode's devcontainer extension, more flexible, works with any editor/ide
  2. vscode's devcontainer extension

## setup

```bash
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash
```

this downloads the `.devcontainer` directory with the base configuration and a helper script to start devpod

## config

1. **create/edit `.devcontainer/.env` with your git identity:**

```bash
GIT_NAME=Your Name
GIT_EMAIL=your.email@example.com
```

## how it works

- **SSH key**: mounts `~/.ssh/id_ed25519` (read-only) for git operations and commit signing
- **git identity**: reads from `.devcontainer/.env` file for name/email configuration
- **container name**: automatically named `devcontainer_<project-folder-name>`

## start container

### with devpod

```bash
# default (vscode)
./devpod.sh

# specify ide
# to view supported ides run `devpod ide list`
./devpod.sh --ide zed

# recreate container (to use an updated container image, for example)
./devpod.sh --recreate
```

### with vscode devcontainer extension

open the project in vscode, click on the devcontainer icon in the bottom left corner (but you'll probably be prompted to reopen the window in the container automatically)
