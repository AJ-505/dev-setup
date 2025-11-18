#!/usr/bin/env bash
set -euo pipefail

# Install zsh
sudo apt install -y zsh

# Set zsh as default shell 
ZSH_PATH=$(command -v zsh || true)
if [ -n "$ZSH_PATH" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Setting zsh as default shell..."
  chsh -s "$ZSH_PATH"
  echo "Default shell set to zsh"
fi

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Invoke zsh here
echo "Zsh is now the shell being used - please proceed to run the master installation script (install-all.zsh)."
zsh