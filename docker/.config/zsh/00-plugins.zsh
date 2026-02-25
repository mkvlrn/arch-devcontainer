plugins=(git)
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/k-git/k.plugin.zsh
source <(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/mkvlrn.omp.json)
source <(mise activate zsh)
