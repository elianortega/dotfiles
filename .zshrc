export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
# CASE_SENSITIVE="true"
# ENABLE_CORRECTION="true"

plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ----------------------
# Git Aliases
# ----------------------
alias gitclean="git for-each-ref --format '%(refname:short)' refs/heads | grep -v \"master\\|main\\|develop\" | xargs git branch -D"
alias cz="cz commit"

# ----------------------
# Flutter Aliases
# ----------------------
alias flutter="fvm flutter"
alias pg="flutter pub get"
alias fcpg="flutter clean && flutter pub get"
alias vpg="very_good packages get -r"

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
# Start starship.rs
# ----------------------
eval "$(starship init zsh)"
