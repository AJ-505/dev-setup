# Dev Setup

Quick and reproducible development environment setup for Ubuntu/WSL.

## Quick Start

### Option 1: Automated Install (Recommended)

```bash
# Run the master install script
chmod +x install-all.sh
./install-all.sh

# After step 1 completes, switch to zsh and re-run
exec zsh
./install-all.sh
```

The script will detect if you're in bash and prompt you to switch to zsh after installing it.

### Option 2: Manual Step-by-Step

Run these commands in order on a fresh Ubuntu installation:

```bash
# 1. Bootstrap Ubuntu with essential tools, zsh, oh-my-zsh, and Neovim
chmod +x ubuntu/scripts/ubuntu-bootstrap.sh
./ubuntu/scripts/ubuntu-bootstrap.sh

# 2. Switch to zsh (required for remaining steps)
exec zsh

# 3. Copy tmux configuration
cp ubuntu/.tmux.conf ~/.tmux.conf

# 4. Install Node.js, npm, pnpm, yarn, Deno, and Bun
chmod +x ubuntu/scripts/install-node-npm.zsh
zsh ubuntu/scripts/install-node-npm.zsh

# 5. Clone Neovim configuration
chmod +x ubuntu/scripts/neovim-setup.zsh
zsh ubuntu/scripts/neovim-setup.zsh
```

## What Gets Installed

### ubuntu-bootstrap.sh
- **System packages**: zsh, unzip, jq, tmux, fzf, ripgrep, bat, fd-find, git, curl, wget, build-essential, python3-pip, libfuse2
- **Shell**: oh-my-zsh + sets zsh as default shell
- **Neovim**: Latest stable AppImage installed to `~/.local/bin/nvim`

### install-node-npm.zsh
- **Node.js**: Latest version via fnm (Fast Node Manager)
- **Global packages**: pnpm, yarn, TypeScript, typescript-language-server, markdownlint-cli
- **Runtimes**: Deno, Bun

### neovim-setup.zsh
- Clones [kickstart.nvim](https://github.com/AJ-505/kickstart.nvim) to `~/.config/nvim`
- Backs up existing config if present

### .tmux.conf
- Prefix remapped to `Ctrl-a` (instead of `Ctrl-b`)
- Sensible split shortcuts: `|` for vertical, `-` for horizontal
- Vim-style pane navigation: `h`, `j`, `k`, `l`
- Mouse support enabled
- Reload config with `Ctrl-a r`

## Manual Steps

After running the scripts:

1. **Reload shell**: `exec zsh` or open a new terminal
2. **First Neovim launch**: Run `nvim` and let plugins install automatically
3. **Verify installations**:
   ```bash
   nvim --version
   node --version
   npm --version
   deno --version
   bun --version
   ```

## Troubleshooting

- **fnm not found after install**: Run `eval "$(fnm env)"` or restart your shell
- **Neovim AppImage won't run**: Ensure `libfuse2` is installed: `sudo apt install libfuse2`
- **oh-my-zsh prompts for shell change**: The bootstrap script runs it unattended, but you may need to `chsh -s $(which zsh)` manually
- **PATH issues**: Ensure `~/.local/bin` is in your PATH (bootstrap script adds it to `.zshrc`)

## Windows-Specific (WSL)

All scripts work in WSL2. If you're using WSL1, you may need to:
- Manually extract the Neovim AppImage instead of running it directly
- Use the tarball version instead

## Customization

- **Add more tools**: Edit `ubuntu/scripts/ubuntu-bootstrap.sh`
- **Change tmux prefix**: Edit `ubuntu/.tmux.conf` (lines 2-4)
- **Neovim config**: Fork and modify [kickstart.nvim](https://github.com/AJ-505/kickstart.nvim)

## Contributing

Contributions welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT - See [LICENSE](LICENSE) for details.
