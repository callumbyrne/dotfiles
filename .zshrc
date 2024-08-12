# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(zsh-nvm git)

source $ZSH/oh-my-zsh.sh

setopt NO_PROMPT_CR
setopt NO_PROMPT_SP

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="brave"

# directories
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/repos"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN="$HOME/second-brain"

# ~~~~~~~~~~~~~~~ Path ~~~~~~~~~~~~~~~~~~~~~~~~

export PATH="$SCRIPTS:$HOME/.local/bin:$PATH"

export NODE_HOME="$HOME/.nvm/versions/node/v18.12.0"
export PATH="$NODE_HOME/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/jdk-14.0.2
export PATH=$JAVA_HOME/bin:$PATH

export NVIM_INSTALL="/usr/local/bin/nvim-linux64"
export PATH="$NVIM_INSTALL/bin:$PATH"

export PATH=/usr/local/go/bin:$PATH

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=5000
export SAVEHIST=5000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias scripts='cd $SCRIPTS'
alias dot='cd $REPOS/dotfiles'
alias repos='cd $REPOS'
alias re='cd $HOME/zunia-local-development-docker/repos'
alias c="clear"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0_inbox/"

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'
