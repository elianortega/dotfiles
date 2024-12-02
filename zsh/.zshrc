# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------
# Add Scripts to path
# ----------------------
export PATH=$PATH:~/.local/scripts
bindkey -s ^f "tmux-sessionizer\n"

# ----------------------
# Git Aliases
# ----------------------
alias gitclean="git for-each-ref --format '%(refname:short)' refs/heads | grep -v \"master\\|main\\|develop\" | xargs git branch -D"
alias cz="cz commit"
alias lzg="lazygit"
alias gco="git checkout" 
alias gcb="git checkout -b" 
alias gaa="git add --all" 
alias gl="git pull"
alias gp="git push"

# ----------------------
# Flutter Aliases
# ----------------------
alias flutter="fvm flutter"
alias pg="flutter pub get"
alias fcpg="flutter clean && flutter pub get"
alias vpg="very_good packages get -r"
alias fbr="flutter pub run build_runner build --delete-conflicting-outputs"

alias oapk="open build/app/outputs/flutter-apk"
alias oappbundle="open build/app/outputs/bundle"
alias oipa="open build/ios/ipa"

# ----------------------
# Export Flutter
# ----------------------
export FLUTTER_HOME=~/fvm/default
PATH=$PATH:$FLUTTER_HOME/bin:$PATH

export DART_HOME=~/fvm/default/bin/cache/dart-sdk
PATH=$PATH:$DART_HOME/bin:$PATH
PATH=$PATH:~/.pub-cache/bin:$PATH

# ----------------------
# Flutter Android
# ----------------------
export ANDROID_HOME=~/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/build-tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin/

# ----------------------
# NVM Installation
# ----------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ----------------------
# OpenJDK Installation
# ----------------------
PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# ----------------------
# Ruby - Need to make sure that use the Homebrew Ruby, not the system one
# Very Good Flutter Setup
# ----------------------
export PATH="/usr/local/opt/ruby/bin:$PATH"


# ----------------------
# Power Level 10k setup
# ----------------------
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----------------------
# Autossugestions
# ----------------------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----------------------
# History setup
# ----------------------
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ----------------------
# Completion with arrows based on history
# ----------------------
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
