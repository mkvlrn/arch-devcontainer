# paths
export BUN_INSTALL="$HOME/.bun"

# PATH
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh plugins
plugins=(git)
source $HOME/.zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.k/k.plugin.zsh

# install completions
pnpm completion zsh >$HOME/.pnpm-completion.zsh
SHELL=zsh bun completions
# load completions
source $HOME/.pnpm-completion.zsh
source $HOME/.bun/_bun

# prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/mkvlrn.omp.json)"

# disable expansion of variables
zstyle ':autocomplete:*' min-input 3
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

# .gitconfig
SSH_KEY=/home/dev/.ssh/devpod
rm -f ~/.gitconfig
touch ~/.gitconfig
chmod 444 ~/.gitconfig
git config --global user.name ${GIT_NAME}
git config --global user.email ${GIT_EMAIL}
git config --global user.signingkey ${SSH_KEY}
git config --global core.sshCommand "ssh -i $SSH_KEY -o IdentitiesOnly=yes -F /dev/null"
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.eol lf
git config --global push.followTags true
git config --global pull.rebase false
git config --global gpg.format ssh
git config --global commit.gpgsign true
