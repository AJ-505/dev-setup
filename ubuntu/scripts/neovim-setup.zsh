#!/usr/bin/env zsh
set -euo pipefail

# Backup existing config if present
if [ -d "$HOME/.config/nvim" ]; then
	mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)"
fi

# Clone your Neovim config
git clone https://github.com/AJ-505/kickstart.nvim "$HOME/.config/nvim"

echo "Neovim config cloned to ~/.config/nvim"
