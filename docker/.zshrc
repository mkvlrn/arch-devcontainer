# PATH
export PATH="$PATH:$NVM_DIR"

# zsh plugins
plugins=(git)
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/k-git/k.plugin.zsh

# nvm
source /usr/share/nvm/init-nvm.sh
# glab
source <(glab completion -s zsh) compdef _glab glab
# pnpm
source /usr/share/zsh/plugins/pnpm-shell-completion/pnpm-shell-completion.zsh

# prompt
eval "$(oh-my-posh init zsh --config /home/dev/mkvlrn.omp.json)"

# disable expansion of variables
zstyle ':autocomplete:*' min-input 3
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored
