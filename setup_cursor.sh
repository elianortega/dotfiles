#!/usr/bin/env zsh

# ---------------------------------------
#  Cursor Setup Script (Portable)
# ---------------------------------------

# Dotfiles location (portable)
DOTFILES_CURSOR="$HOME/dotfiles/cursor/User"

# Cursor settings location (macOS + Linux auto-detect)
if [[ "$OSTYPE" == "darwin"* ]]; then
  CURSOR_USER_PATH="$HOME/Library/Application Support/Cursor/User"
else
  CURSOR_USER_PATH="$HOME/.config/Cursor/User"
fi

echo "Dotfiles Cursor path: $DOTFILES_CURSOR"
echo "Cursor User path: $CURSOR_USER_PATH"

# ---------------------------------------
# Ensure dotfiles folder exists
# ---------------------------------------
if [[ ! -d "$DOTFILES_CURSOR" ]]; then
  echo "Creating dotfiles Cursor directory..."
  mkdir -p "$DOTFILES_CURSOR"
fi

# ---------------------------------------
# Backup existing Cursor settings (only if it's a real folder, not a symlink)
# ---------------------------------------
if [[ -d "$CURSOR_USER_PATH" && ! -L "$CURSOR_USER_PATH" ]]; then
  echo "Backing up original Cursor settings..."
  mv "$CURSOR_USER_PATH" "$CURSOR_USER_PATH.backup"
fi

# ---------------------------------------
# Create symlink from Cursor → dotfiles
# ---------------------------------------
echo "Creating symlink..."
rm -rf "$CURSOR_USER_PATH"
ln -s "$DOTFILES_CURSOR" "$CURSOR_USER_PATH"

echo "Symlink created!"

# ---------------------------------------
# Export installed extensions into dotfiles
# ---------------------------------------
echo "Exporting Cursor extensions..."
EXT_FILE="$HOME/dotfiles/cursor/cursor-extensions.txt"
cursor --list-extensions > "$EXT_FILE"

echo "Extensions saved to $EXT_FILE"

# ---------------------------------------
# Install extensions from the list (for new machines)
# ---------------------------------------
if [[ -f "$EXT_FILE" ]]; then
  echo "Installing extensions from list..."
  xargs -L 1 cursor --install-extension < "$EXT_FILE"
fi

echo "Cursor setup complete! 🎉"
