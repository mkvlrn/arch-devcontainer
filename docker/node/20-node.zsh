# paths
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"

# PATH
export PATH="$BUN_INSTALL/bin:$NVM_DIR:$PATH"

# nvm
source /usr/share/nvm/init-nvm.sh

# completions
mkdir -p $BUN_INSTALL
source /usr/share/zsh/plugins/pnpm-shell-completion/pnpm-shell-completion.zsh
SHELL=zsh bun completions >$BUN_INSTALL/_bun
source $BUN_INSTALL/_bun
