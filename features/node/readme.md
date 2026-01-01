# node feature

`ghcr.io/mkvlrn/arch-devcontainer/node`

## packages

- nvm
- pnpm-bin
- pnpm-shell-completion

## options

| Option        | Default | Description                     |
| ------------- | ------- | ------------------------------- |
| `nodeVersion` | `24`    | node version to install via nvm |

## usage

```json
{
  "features": {
    "ghcr.io/mkvlrn/arch-devcontainer/node:latest": {
      "nodeVersion": "22"
    }
  }
}
```
