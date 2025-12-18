# arch-devcontainer

## what is this

a devcontainer setup using arch linux as base image, with optional features for different development stacks (node, go, python, dotnet)

## requirements

- docker
- [devpod](https://devpod.sh/) - better than vscode's devcontainer extension, more flexible, works with any editor/ide

## setup

```bash
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash
```

this downloads the `.devcontainer` directory with the base configuration and all available features

## config

1. copy `.devcontainer/.env.devcontainer.example` to `.devcontainer/.env.devcontainer`
2. edit the values to match your needs (git info, ssh key path, timezone, editor)
3. edit `.devcontainer/devcontainer.json` to add the features you need:

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

## available features

| Feature                                   | Description                                           |
| ----------------------------------------- | ----------------------------------------------------- |
| `ghcr.io/mkvlrn/arch-devcontainer/node`   | nvm, pnpm, bun (option: `nodeVersion`, default: `24`) |
| `ghcr.io/mkvlrn/arch-devcontainer/go`     | go + tools (gopls, delve, golangci-lint, etc.)        |
| `ghcr.io/mkvlrn/arch-devcontainer/python` | uv package manager + `newpy` helper function          |
| `ghcr.io/mkvlrn/arch-devcontainer/dotnet` | dotnet sdk                                            |

## start container (with devpod)

```bash
./.devcontainer/devpod.sh
```

pass `--recreate` to start fresh:

```bash
./.devcontainer/devpod.sh --recreate
```
