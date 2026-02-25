# disable expansion of variables
zstyle ':completion:*:*:git-clone:*' tag-order 'device-nodes'
zstyle ':autocomplete:*' min-input 3
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored
