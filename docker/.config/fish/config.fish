if status is-interactive
    # Commands to run in interactive sessions can go here
end

# no logo
set -g fish_greeting

# mise
mise activate fish | source

# glab completions
glab completion -s fish | source

# oh-my-posh
oh-my-posh init fish --config $HOME/.config/mkvlrn.omp.json | source
