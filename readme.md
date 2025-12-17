# arch-devcontainer

## what is this

a simple devcontainer config using archlinux base image

couple images available for different stacks: node, go, python

## requirements

- docker
- [devpod](https://devpod.sh/) - it is better than vscode's devcontainer extension, and more flexible, as it allows you to use _any_ editor/ide and get configurations to make life easier

## setup

this adds the devcontainer configuration and the script to start it using devpod

```bash
# node env
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash -s -- node

# go env
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash -s -- go

# python env
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash -s -- python
```

## config

create `./.devcontainer/.env.devcontainer` based on `./.devcontainer/.env.devcontainer.example` and adjust values to match your needs; it's only git info, the ssh key to be used (it will be mounted into the devcontainer), your timezone, and what editor you'll be using

## start container (with devpod)

```bash
./.devcontainer/devpod.sh
```

you can pass the `--recreate` option to start with a fresh container
