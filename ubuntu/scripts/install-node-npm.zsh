#!/usr/bin/env zsh
set -euo pipefail

# Install fnm (Fast Node Manager)
if ! command -v fnm &>/dev/null; then
	curl -fsSL https://fnm.vercel.app/install | zsh
	export PATH="$HOME/.fnm/bin:$PATH"
fi

# Get the latest Node.js version (strip the 'v' prefix)
LATEST_NODE=$(curl -s https://nodejs.org/dist/index.json | jq -r '.[0].version[1:]')
fnm install "$LATEST_NODE"
fnm use "$LATEST_NODE"
fnm default "$LATEST_NODE"

# Ensure fnm is loaded in shell
if ! grep -q 'fnm env' "$HOME/.zshrc"; then
	echo 'eval "$(fnm env)"' >> "$HOME/.zshrc"
fi

# Verify installation
node -v
npm -v

# Install global npm packages
npm install -g pnpm yarn typescript typescript-language-server markdownlint-cli
# Deno and Bun are separate runtimes, install via their official scripts
if ! command -v deno &>/dev/null; then
	curl -fsSL https://deno.land/install.sh | sh
fi
if ! command -v bun &>/dev/null; then
	curl -fsSL https://bun.sh/install | bash
fi