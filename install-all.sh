#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "  Dev Environment Setup"
echo "=========================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Bootstrap Ubuntu (installs zsh, sets as default, installs tools + Neovim)
echo "Step 1/4: Installing essential packages, zsh, and Neovim..."
echo "Note: This installs zsh and sets it as your default shell."
echo ""
chmod +x "$SCRIPT_DIR/ubuntu/scripts/ubuntu-bootstrap.sh"
"$SCRIPT_DIR/ubuntu/scripts/ubuntu-bootstrap.sh"
echo "[OK] Bootstrap complete"
echo ""

# 2. Copy tmux config
echo "Step 2/4: Setting up tmux configuration..."
cp "$SCRIPT_DIR/ubuntu/.tmux.conf" "$HOME/.tmux.conf"
echo "[OK] tmux.conf copied to $HOME"
echo ""

# Check if we're running in zsh, if not warn user
if [ -z "$ZSH_VERSION" ]; then
  echo "WARNING: You're still running bash."
  echo "   The next steps require zsh. Please run: exec zsh"
  echo "   Then re-run this script, or manually run the remaining steps:"
  echo "   - zsh $SCRIPT_DIR/ubuntu/scripts/install-node-npm.zsh"
  echo "   - zsh $SCRIPT_DIR/ubuntu/scripts/neovim-setup.zsh"
  echo ""
  exit 0
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
