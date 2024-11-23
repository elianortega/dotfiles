
#!/bin/bash

# Define paths
DOTFILES_VSCODE_PATH="$HOME/dotfiles/vscode"
VSCODE_SETTINGS_PATH="$HOME/Library/Application Support/Code/User/profiles/-23749998"

# Ensure source files exist
if [[ ! -f "$DOTFILES_VSCODE_PATH/settings.json" ]] || [[ ! -f "$DOTFILES_VSCODE_PATH/keybindings.json" ]]; then
  echo "Error: settings.json or keybindings.json not found in $DOTFILES_VSCODE_PATH"
  exit 1
fi

# Create the VSCode directory if it doesn't exist
mkdir -p "$VSCODE_SETTINGS_PATH"

# Copy settings and keybindings from dotfiles to VSCode
echo "Restoring VSCode settings and keybindings from dotfiles..."
cp "$DOTFILES_VSCODE_PATH/settings.json" "$VSCODE_SETTINGS_PATH/settings.json"
cp "$DOTFILES_VSCODE_PATH/keybindings.json" "$VSCODE_SETTINGS_PATH/keybindings.json"
echo "Restore complete! Files have been copied to $VSCODE_SETTINGS_PATH."