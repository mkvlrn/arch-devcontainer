# paths
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"

# PATH
export PATH="$BUN_INSTALL/bin:$NVM_DIR:$PATH"

# zsh plugins
plugins=(git)
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/k-git/k.plugin.zsh
source /usr/share/zsh/plugins/pnpm-shell-completion/pnpm-shell-completion.zsh
source /usr/share/nvm/init-nvm.sh

# bun completions
mkdir -p $BUN_INSTALL
SHELL=zsh bun completions >$BUN_INSTALL/_bun
source $HOME/.bun/_bun

# prompt
eval "$(oh-my-posh init zsh --config negligible)"

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
