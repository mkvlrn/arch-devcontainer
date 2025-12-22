# arch-devcontainer

## what is this

a devcontainer setup using arch linux as base image, with optional features for different development stacks (node, go, python, dotnet)

## requirements

- docker
- a linux-like shell (git-bash is good enough on windows)
- an ssh key ready to be used for git operations
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

2. **edit `.devcontainer/devcontainer.json` to add features you need:**

```json
json
{
  "features": {
    "ghcr.io/mkvlrn/arch-devcontainer/node:latest": {},
    "ghcr.io/mkvlrn/arch-devcontainer/go:latest": {},
    "ghcr.io/mkvlrn/arch-devcontainer/python:latest": {},
    "ghcr.io/mkvlrn/arch-devcontainer/dotnet:latest": {},
  }
}
```

or with options:

```json
json
{
  "features": {
    "ghcr.io/mkvlrn/arch-devcontainer/node:latest": {
      "nodeVersion": "22"
    }
  }
}
```

## available features

| Feature                                   | Description                                           |
| ----------------------------------------- | ----------------------------------------------------- |
| `ghcr.io/mkvlrn/arch-devcontainer/node`   | nvm, pnpm, bun (option: `nodeVersion`, default: `24`) |
| `ghcr.io/mkvlrn/arch-devcontainer/go`     | go + tools (gopls, delve, golangci-lint, etc.)        |
| `ghcr.io/mkvlrn/arch-devcontainer/python` | uv package manager + `newpy` helper function          |
| `ghcr.io/mkvlrn/arch-devcontainer/dotnet` | dotnet sdk                                            |

## how it works

- **SSH key**: mounts `~/.ssh/id_ed25519` (read-only) for git operations and commit signing
- **git identity**: reads from `.devcontainer/.env` file for name/email configuration
- **container name**: automatically named `devcontainer_<project-folder-name>`

## start container

### with devpod

```bash
# default (vscode)
./.devcontainer/devpod.sh

# specify ide
# to view supported ides run `devpod ide list`
./.devcontainer/devpod.sh --ide zed

# recreate container (to use an updated container image, for example)
./.devcontainer/devpod.sh --recreate
```

### with vscode devcontainer extension

open the project in vscode, click on the devcontainer icon in the bottom left corner (but you'll probably be prompted to reopen the window in the container automatically)
