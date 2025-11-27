#!/usr/bin/env zsh

personal_folders=("git")
cd .dotfiles-personal
for folder in "${personal_folders[@]}"; do
  echo "Unstowing .dotfiles-personal/$folder..."
  stow --delete -t ~ "$folder"
done
cd ..

# Define the list of folders to unstow
folders=("wezterm" "bin" "nvim" "skhd" "zsh")

# Loop through each folder and run stow --delete
for folder in "${folders[@]}"; do
  echo "Unstowing $folder..."
  stow --delete -t ~ "$folder"
done

# Unstow personal .config folders
stow --delete --no-folding -v -t ~/.config config

echo "All symlinks have been removed!"


