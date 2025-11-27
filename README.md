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

5. Install 1Password:
```bash
brew install --cask 1password
```

6. Clone repo and setup:
```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./setup.sh
```

7. Install all casks:
```bash
xargs brew install --cask < casks.txt
```

**Note:** `setup.sh` uses `stow` to create symlinks (not copies), so your config files stay in the repo and are cleanly linked to your home directory.
