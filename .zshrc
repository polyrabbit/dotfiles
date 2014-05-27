# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="fletcherm"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pip autojump brew brew-cask sudo)

source $ZSH/oh-my-zsh.sh

# Ensure /usr/local/bin occurs before /usr/bin for the sake of Homebrew
export PATH=/usr/local/bin:$PATH
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# java stuff
# JAVA_HOME='/usr/lib/java/jdk1.7.0_25'
# CLASSPATH='.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar'
# export PATH=$JAVA_HOME/bin:$PATH

if which fcitx >&/dev/null; then
    alias gvim='gvim 2>/dev/null'
    alias vim='vim 2>/dev/null'
fi

alias free='free -m'
alias http='python -m SimpleHTTPServer'
alias sudo='sudo -E'

alias tn='notify-send done'
if [[ $(uname) == "Darwin" ]]; then
    alias mchrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-agent="Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53"'
    # time-consuming command; tn
    alias tn='terminal-notifier -message done -sound  default'
fi

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
