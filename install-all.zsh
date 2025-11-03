#!/usr/bin/env zsh
set -euo pipefail

echo "=========================================="
echo "  Dev Environment Setup"
echo "=========================================="

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

# 1. Bootstrap Ubuntu (first ensure zsh is involved, installs tools + Neovim)
echo "Step 1/4: Installing essential packages and Neovim..."
echo "Note: Please ensure zsh has been installed and set as the default shell."
echo "If it hasn't, please run the initial-setup-script.sh script in the ubuntu/scripts folder."

if [ "$(ps -p $$ -o comm=)" = "zsh" ]; then
  echo "Running inside zsh"
else
  echo "You're not running inside zsh. Please run the initial-setup-script.sh script in the ubuntu/scripts folder."
  exit 1
fi

chmod +x "$SCRIPT_DIR/ubuntu/scripts/ubuntu-bootstrap.zsh"
"$SCRIPT_DIR/ubuntu/scripts/ubuntu-bootstrap.zsh"
echo "[OK] Bootstrap complete"
echo ""

# 2. Copy tmux config
echo "Step 2/4: Setting up tmux configuration..."
cp "$SCRIPT_DIR/ubuntu/.tmux.conf" "$HOME/.tmux.conf"
echo "[OK] tmux.conf copied to $HOME"
echo ""

# Ensure zsh is installed and resolvable
if ! command -v zsh >/dev/null 2>&1; then
  echo "ERROR: zsh not found in PATH after bootstrap."
  echo "Please log out/in (or open a new terminal) and run this script again."
  exit 1
fi

# 3. Install Node.js ecosystem (requires zsh)
echo "Step 3/4: Installing Node.js, Deno, and Bun..."
chmod +x "$SCRIPT_DIR/ubuntu/scripts/install-node-npm.zsh"
zsh "$SCRIPT_DIR/ubuntu/scripts/install-node-npm.zsh"
echo "[OK] Node.js ecosystem installed"
echo ""

# 4. Setup Neovim config
echo "Step 4/4: Cloning Neovim configuration..."
chmod +x "$SCRIPT_DIR/ubuntu/scripts/neovim-setup.zsh"
zsh "$SCRIPT_DIR/ubuntu/scripts/neovim-setup.zsh"
echo "[OK] Neovim config cloned"
echo ""

echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Your default shell is now zsh (effective on next login)"
echo "  2. Launch nvim and let plugins install"
echo "  3. Verify: nvim --version && node --version"
echo ""
