#!/usr/bin/env zsh

personal_folders=("git")
cd .dotfiles-personal
for folder in "${personal_folders[@]}"; do
  echo "Stowing .dotfiles-personal/$folder..."
  stow --restow -t ~ "$folder"
done
cd ..

# Define the list of folders to stow
folders=("wezterm" "bin" "nvim" "skhd"  "tmux" "zsh")

# Loop through each folder and run stow
for folder in "${folders[@]}"; do
  echo "Stowing $folder..."
  stow --restow -t ~ "$folder"
done

echo "All folders have been stowed!"
