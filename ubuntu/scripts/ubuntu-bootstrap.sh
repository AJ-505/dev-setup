#!/usr/bin/env bash
set -euo pipefail

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install core CLI tools
sudo apt install -y \
  zsh unzip jq yq tmux fzf ripgrep bat fd-find git curl wget build-essential python3-pip \
  libfuse2

# Symlink batcat to bat if needed
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

# Symlink fd-find to fd if needed
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  sudo ln -s $(command -v fdfind) /usr/local/bin/fd
fi

# Set zsh as default shell (do this BEFORE oh-my-zsh)
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

# Install Neovim (latest AppImage)
LATEST_TAG=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)
NVIM_URL="https://github.com/neovim/neovim/releases/download/${LATEST_TAG}/nvim-linux-x86_64.appimage"
NVIM_APPIMAGE="$HOME/.local/bin/nvim.appimage"
mkdir -p "$HOME/.local/bin"
curl -L "$NVIM_URL" -o "$NVIM_APPIMAGE"
chmod u+x "$NVIM_APPIMAGE"
ln -sf "$NVIM_APPIMAGE" "$HOME/.local/bin/nvim"

# Add ~/.local/bin to PATH if not present
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Invoke zsh
zsh

cat <<EOF
\nSetup complete!\n- Zsh is your default shell\n- Oh My Zsh installed\n- Neovim (latest) installed as ~/.local/bin/nvim\n- Essential CLI tools installed\nEOF