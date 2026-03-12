# disable nextjs telemetry
set -gx NEXT_TELEMETRY_DISABLED 1
# disable prisma telemetry
set -gx CHECKPOINT_DISABLE 1
# initially for crontab, maybe others, idk
set -gx VISUAL "code --wait"
set -gx EDITOR "code --wait"
# turbo
set -gx TURBO_TELEMETRY_DISABLED 1
set -gx DO_NOT_TRACK 1
# varlock
set -gx VARLOCK_TELEMETRY_DISABLED true
# paths
set -gx HOME_BIN "$HOME/.local/bin"
set -gx USR_LOCAL_BIN /usr/local/bin
# PATH
fish_add_path --prepend $HOME_BIN $USR_LOCAL_BIN
