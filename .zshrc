# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="tjkirch_mod"
#ZSH_THEME="steeef"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
COMPLETION_WAITING_DOTS="false"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting brew sudo macos golang dotenv rust fzf)

source $ZSH/oh-my-zsh.sh
# export PROMPT='%{$fg_no_bold[cyan]%}%n%{$fg_no_bold[magenta]%}•%{$fg_no_bold[cyan]%}%m %{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}» '

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# Ensure /usr/local/bin occurs before /usr/bin for the sake of Homebrew
# export PATH=/usr/local/bin:$PATH
export EDITOR=vim
# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# java stuff
# JAVA_HOME='/usr/lib/java/jdk1.7.0_25'
# CLASSPATH='.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar'
# export PATH=$JAVA_HOME/bin:$PATH

export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
export ANDROID_HOME=/usr/local/share/android-sdk

# Should correlate with ZSH_THEME
# PROMPT='%(?,,%{$fg[red]%}FAIL: $?%{$reset_color%}
# )%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[cyan]%}%~%{$reset_color%}$(git_prompt_info)
# %_$(prompt_char) '

#alias free='free -h'
# alias sudo='sudo -E'

alias tn='notify-send done'
if [[ $(uname) == "Darwin" ]]; then
    # time-consuming command; tn
    alias tn='terminal-notifier -message done -sound  default'
fi

# git commit & push
function gcp { git commit $@ && git push }

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

# go
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export HOMEBREW_NO_AUTO_UPDATE=1
export LC_ALL=en_US.UTF-8

### Added by the Bluemix CLI
# source /usr/local/Bluemix/bx/zsh_autocomplete
# . "~/.acme.sh/acme.sh.env"

export GOPROXY=https://goproxy.cn

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#eval "$(atuin init zsh)"

PATH=$PATH:$HOME/bin
