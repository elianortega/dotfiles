#!/bin/bash

# Define paths
VSCODE_SETTINGS_PATH="$HOME/Library/Application Support/Code/User/profiles/-23749998"
DOTFILES_VSCODE_PATH="$HOME/dotfiles/vscode"

# Create the destination directory if it doesn't exist
mkdir -p "$DOTFILES_VSCODE_PATH"

# Copy VSCode settings and keybindings to dotfiles
echo "Syncing VSCode settings and keybindings to dotfiles..."
cp "$VSCODE_SETTINGS_PATH/settings.json" "$DOTFILES_VSCODE_PATH/settings.json"
cp "$VSCODE_SETTINGS_PATH/keybindings.json" "$DOTFILES_VSCODE_PATH/keybindings.json"
echo "Sync complete! Files are now in $DOTFILES_VSCODE_PATH."
