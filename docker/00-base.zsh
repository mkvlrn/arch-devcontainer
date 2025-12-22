# zsh plugins
plugins=(git)
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/k-git/k.plugin.zsh

# prompt
eval "$(oh-my-posh init zsh --config /home/dev/.config/zsh/mkvlrn.omp.json)"

# disable expansion of variables
zstyle ':autocomplete:*' min-input 3
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

alias ls="k"
