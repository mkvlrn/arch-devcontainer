ZSH_DIR="$HOME/.config/zsh"
for file in "$ZSH_DIR"/*.zsh(N); do
  source "$file"
done