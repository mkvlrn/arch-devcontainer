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

# git setup function
git_setup() {
    local name="${1:?Error: user.name is required}"
    local email="${2:?Error: user.email is required}"
    # user settings
    git config --global user.name "$name"
    git config --global user.email "$email"
    # init
    git config --global init.defaultBranch main
    # core settings
    git config --global core.editor "code --wait"
    git config --global core.autocrlf false
    git config --global core.safecrlf false
    git config --global core.eol lf
    # push/pull
    git config --global push.followTags true
    git config --global pull.rebase false
    # gpg signing with ssh
    git config --global gpg.format ssh
    git config --global commit.gpgsign true
    # aliases
    git config --global alias.k '!git add --all && git commit -m'
    git config --global alias.s '!git status -s'
    git config --global alias.l "!git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'"
    git config --global alias.a '!git add --all && git commit --amend --no-edit -m'
    git config --global alias.t "!git log --graph --decorate --abbrev-commit --pretty=format:'%C(yellow)%h%Creset %C(magenta)%ad%Creset%C(auto)%d%Creset %s %C(cyan)[%an]%Creset' --date=short"
    echo "Git configured for $name <$email>"
}
