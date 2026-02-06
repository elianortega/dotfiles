export ZSH="$HOME/.oh-my-zsh"

# ----------------------
# Add Scripts to path
# ----------------------
export PATH=$PATH:~/.local/scripts

# ----------------------
# TMUX NVIM ALIASES
# ----------------------
alias n="nvim"
alias c="cursor"

# ----------------------
# Eza better ls
# ----------------------
alias ls="eza --icons=always"


# ----------------------
# Zoxide better cd
# ----------------------
eval "$(zoxide init zsh)"
alias cd="z"


# ----------------------
# Git Aliases
# ----------------------
alias gitclean="git for-each-ref --format '%(refname:short)' refs/heads | grep -v \"master\\|main\\|develop\" | xargs git branch -D"
alias cz="cz commit"
alias lg="lazygit"
alias gco="git checkout" 
alias gcb="git checkout -b" 
alias gaa="git add --all" 
alias gl="git pull"
alias gp="git push"
alias ..="cd .."

# ----------------------
# Flutter Aliases
# ----------------------
alias flutter="fvm flutter"
alias dart="fvm dart"
alias pg="flutter pub get"
alias fcpg="flutter clean && flutter pub get"
alias vpg="very_good packages get -r"
alias vgt='very_good test -j 4 --optimization --coverage --exclude-coverage "lib/generated/**" --test-randomize-ordering-seed random'
alias fbr="flutter pub run build_runner build --delete-conflicting-outputs"

alias oapk="open build/app/outputs/flutter-apk"
alias oappbundle="open build/app/outputs/bundle"
alias oipa="open build/ios/ipa"
alias f10n="flutter gen-l10n"

# ----------------------
# Export Flutter
# ----------------------
export FLUTTER_HOME=~/fvm/default
PATH=$PATH:$FLUTTER_HOME/bin:$PATH

# export DART_HOME=~/fvm/default/bin/cache/dart-sdk
# PATH=$PATH:$DART_HOME/bin:$PATH
PATH=$PATH:~/.pub-cache/bin:$PATH

# ----------------------
# Flutter NVIM
# ----------------------
# I want to use $@ for all arguments but they don't contain space for me
# I want to use $@ for all arguments but they don't contain space for me
function fw(){
  tmux send-keys "flutter run $1 $2 $3 $4 $5 $6 $7 $8 --pid-file=/tmp/tf1.pid" Enter \;\
  split-window -v \;\
  send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
  resize-pane -y 5 -t 1 \;\
  select-pane -t 0 \;
}

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

# ----------------------
# Protocol Buffers
# ----------------------
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"

# ----------------------
# RUST
# ----------------------
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# ----------------------
# OH MY ZSH
# ----------------------
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/elianortega/.dart-cli-completion/zsh-config.zsh ]] && . /Users/elianortega/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export PATH="/Users/elianortega/.shorebird/bin:$PATH"

# Work Aliases

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
