# Setup

## New Mac Setup

1. Check shell (macOS uses zsh by default):
```bash
echo $SHELL
# Should show /bin/zsh
```

2. Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Add Homebrew to PATH (new terminal):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

4. Install stow (required for dotfiles):
```bash
brew install stow
```

5. Clone repo and setup:
```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./setup.sh
```

6. Install all packages:
```bash
grep -v '^#' brew/formulas.txt | xargs brew install
xargs brew install --cask < brew/casks.txt
```

**Note:** `setup.sh` uses `stow` to create symlinks (not copies), so your config files stay in the repo and are cleanly linked to your home directory.

## Post-Install Setup

### Initialize Git Submodules

The nvim config is a git submodule. After cloning, initialize it:

```bash
cd ~/dotfiles
git submodule update --init --recursive
```

### Tmux Plugin Manager (TPM)

Install TPM to enable tmux plugins:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then start tmux and press `Ctrl+s I` (capital I) to install plugins.

### Neovim

On first launch, neovim will auto-install plugins via lazy.nvim. Just run:

```bash
nvim
```

Wait for plugins to install, then restart nvim.

---

## Quick Reference

### Tmux

**Prefix:** `Ctrl+s`

| Keybinding | Action |
|------------|--------|
| `prefix + I` | Install plugins (TPM) |
| `prefix + R` | Reload config |
| `prefix + v` | Split vertical |
| `prefix + h` | Split horizontal |
| `prefix + z` | Zoom/unzoom pane |
| `prefix + c` | Kill pane |
| `prefix + r` | Rename window |
| `prefix + w` | List windows |
| `prefix + Ctrl+c` | New window |
| `prefix + Ctrl+d` | Detach |
| `prefix + , / .` | Resize pane left/right |
| `prefix + - / =` | Resize pane down/up |
| `prefix + Left/Right` | Swap window position |
| `prefix + K` | Clear screen |
| `prefix + T` | Session picker (sesh + fzf) |

**Mouse:** Enabled for pane selection and resizing.

**Vim-tmux-navigator:** Use `Ctrl+h/j/k/l` to move between tmux panes and nvim splits seamlessly.

### Neovim

**Leader:** Check your config (commonly `Space`)

| Keybinding | Action |
|------------|--------|
| `:Lazy` | Open plugin manager |
| `:LazySyncs` | Update all plugins |
| `:Mason` | Open LSP/formatter installer |
| `:checkhealth` | Diagnose issues |

**Common lazy.nvim keymaps:**

| Keybinding | Action |
|------------|--------|
| `Ctrl+h/j/k/l` | Navigate splits (vim-tmux-navigator) |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle selection comment |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ff` | Find files (telescope) |
| `<leader>fg` | Live grep (telescope) |
| `<leader>e` | File explorer |

**Note:** Actual keybindings depend on your nvim config. Run `:map` to see all mappings or check your nvim repo.

### Development secrets (evault)

Secrets live in an encrypted private repo managed by the `evault` CLI
(github.com/elianortega/evault). The only key is the 1Password item
"evault age key" (Private vault).

```bash
git clone git@github.com:elianortega/evault.git ~/development/evault
~/development/evault/install.sh
# 1Password app: Settings > Developer > Integrate with 1Password CLI
evault setup git@github.com:elianortega/evault-data.git
```

The `evault` skill (`claude/.claude/skills/evault`) tells AI sessions how to
store and use secrets; the global CLAUDE.md requires it.
