# Installation Order & Dependencies

This document verifies the correct installation order to avoid dependency issues. Will be useful if you intend to run the scripts individually yourself.

## Step 0 (pre-requisite): Ensure zsh is installed (and set as default), with.. Oh My ZSH! - initial-setup-script.sh

## Step 1: ubuntu-bootstrap.sh (runs in bash)

**Installs in order:**
1. [OK] `sudo apt update && sudo apt upgrade -y`
2. [OK] Core tools (all installed in single apt command):
   - `zsh` - required for all subsequent .zsh scripts
   - `unzip` - required by fnm installer
   - `jq` - required for parsing GitHub API (Neovim latest tag)
   - `curl`, `wget` - required for downloading installers
   - `git` - required for cloning repos
   - `build-essential` - required for compiling native modules (Neovim dependencies)
   - `libfuse2` - required for running AppImage files
   - `tmux`, `fzf`, `ripgrep`, `bat`, `fd-find`, `python3-pip` - CLI utilities
3. [OK] Symlink `batcat` → `bat` (Ubuntu-specific fix)
4. [OK] Symlink `fdfind` → `fd` (Ubuntu-specific fix)
5. [OK] Set zsh as default shell (`chsh -s $(which zsh)`)
6. [OK] Install oh-my-zsh (uses `curl`, runs AFTER zsh installed)
7. [OK] Install Neovim AppImage (uses `curl`, `jq`, `libfuse2` - all already installed)

**Dependencies satisfied:** [OK] All dependencies installed before use

## Step 2: Copy tmux.conf

No dependencies, just a file copy.

## Step 3: install-node-npm.zsh (runs in zsh)

**Requires:**
- [OK] `zsh` - installed in Step 1
- [OK] `curl` - installed in Step 1
- [OK] `unzip` - installed in Step 1 (required by fnm installer)
- [OK] `jq` - installed in Step 1 (required for parsing Node.js versions)

**Installs:**
1. fnm (Fast Node Manager) - downloads and installs to `~/.fnm`
2. Latest Node.js version (using fnm)
3. Global npm packages: pnpm, yarn, TypeScript, typescript-language-server, markdownlint-cli
4. Deno (via official installer)
5. Bun (via official installer)

**Dependencies satisfied:** [OK] All required by fnm/npm already installed

## Step 4: neovim-setup.zsh (runs in zsh)

**Requires:**
- [OK] `zsh` - installed in Step 1
- [OK] `git` - installed in Step 1
- [OK] `nvim` - installed in Step 1

**Does:**
1. Backs up existing `~/.config/nvim` if present
2. Clones kickstart.nvim repo to `~/.config/nvim`

**Dependencies satisfied:** [OK] All required tools already installed

## Critical Order Issues Avoided

1. [OK] **fnm requires unzip** - unzip installed BEFORE fnm in step 1
2. [OK] **Neovim AppImage requires libfuse2** - libfuse2 installed BEFORE downloading AppImage
3. [OK] **GitHub API parsing requires jq** - jq installed BEFORE fetching Neovim/Node versions
4. [OK] **zsh scripts require zsh** - zsh installed and set as default BEFORE .zsh scripts run
5. [OK] **oh-my-zsh requires curl and zsh** - both installed BEFORE oh-my-zsh installer runs
6. [OK] **git clone requires git** - git installed BEFORE neovim-setup.zsh

## Shell Transition

**Problem:** Scripts start in bash, but need zsh for fnm/node scripts.

**Solution:**
- `install-all.sh` detects if running in bash
- After Step 1 completes (which installs zsh), script warns user to `exec zsh`
- User switches to zsh, re-runs script
- Script detects zsh and continues with Steps 2-4

This ensures fnm and other zsh-dependent tools work correctly.
