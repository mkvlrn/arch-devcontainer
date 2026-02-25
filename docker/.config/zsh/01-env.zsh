# some tokens
# initially for crontab, maybe others, idk
export VISUAL="code --wait"
export EDITOR="code --wait"
# turbo
export TURBO_TELEMETRY_DISABLED=1
export DO_NOT_TRACK=1
# varlock
export VARLOCK_TELEMETRY_DISABLED=true

# paths
export HOME_BIN="$HOME/.local/bin"
export USR_LOCAL_BIN="/usr/local/bin"

# PATH
export PATH="$HOME_BIN:$USR_LOCAL_BIN:$PATH"
