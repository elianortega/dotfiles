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

# Stow personal .config folders
stow --restow --no-folding -v -t ~/.config config

# config_folders=("aerospace")
# cd config
# for folder in "${config_folders[@]}"; do
#   echo "Stowing .config/$folder..."
#   stow --no-folding -v -t ~/.config "$folder"
# done
# cd ..

echo "All folders have been stowed!"
