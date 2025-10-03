# Contributing to dev-setup

Thanks for your interest in improving this dev setup!

This is primarily a personal setup repo, but contributions are welcome if you have:
- Bug fixes
- Useful utilities that many devs would benefit from
- Documentation improvements
- Performance improvements

## Quick Guidelines

### Before You Contribute

1. **Check existing issues** - Someone might already be working on it
2. **Keep it minimal** - This setup is intentionally lean and focused on essentials
3. **Test on Ubuntu/WSL** - Make sure it works on a fresh Ubuntu 22.04+ or WSL2



### How to Contribute

1. **Fork the repo** and create a feature branch
   ```bash
   git checkout -b fix/your-bug-fix
   # or
   git checkout -b feature/add-useful-tool
   ```

2. **Make your changes**
   - Follow the existing script style (use `set -e`, add comments, check if already installed)
   - Test on a fresh Ubuntu VM or WSL instance
   - Update the README if you add a new tool or change the flow

3. **Commit with clear messages**
   ```bash
   git commit -m "fix: correct fnm version parsing in install-node-npm.zsh"
   # or
   git commit -m "feat: add starship prompt to ubuntu-bootstrap.sh"
   ```

4. **Open a Pull Request**
   - Explain what you changed and why
   - If it's a new tool, explain why it's useful for most devs
   - Reference any related issues

### Reporting Bugs

Found a bug? Please open an issue with:
- **OS/Environment**: Ubuntu version, WSL1/2, architecture (x86_64/ARM64)
- **What happened**: Error messages, unexpected behavior
- **What you expected**: What should have happened
- **Steps to reproduce**: Ideally on a fresh Ubuntu install

Example:
```
**Environment**: Ubuntu 24.04 on WSL2 (x86_64)
**Issue**: fnm fails to install Node.js with "version not found" error
**Expected**: Should install latest Node.js version
**Steps**:
1. Run `./install-all.sh`
2. After zsh switch, fnm install fails
**Error**: `fnm install v22.9.0` returns "version not found"
```

### Testing Your Changes

Before submitting:

1. **Test on a clean environment**
   ```bash
   # Spin up a fresh Ubuntu container or VM
   docker run -it ubuntu:24.04 /bin/bash
   # or use multipass, WSL, etc.
   ```

2. **Run the full install**
   ```bash
   ./install-all.sh
   ```

3. **Verify tools work**
   ```bash
   nvim --version
   node --version
   tmux -V
   ```

## Questions?

Feel free to open an issue with the "question" label, or just ask in a PR! I'm happy to help.

---

Thanks for helping make this setup better!
