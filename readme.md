# arch-devcontainer

## what is this

a simple devcontainer config using archlinux base image for node development

## requirements

- docker
- [devpod](https://devpod.sh/) - optional, can be used with vscode's devcontainer extension, but that's too restrictive

## setup

this adds the devcontainer configuration and the script to start it using devpod

```bash
curl -sL https://raw.githubusercontent.com/mkvlrn/arch-devcontainer/main/setup.sh | bash
```

## config

adjust the values in `./.devcontainer/.env.devcontainer` to match your needs; it's only git info, the ssh key to be used (it will be mounted into the devcontainer), and what editor you'll be using

## start container (with devpod)

```bash
./devcontainer.sh
```

you can pass the `--recreate` option to start with a fresh container
