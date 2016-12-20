##########
# .zshrc for >=zsh-4.2.3
#   written by Boris Smus <boris@smus.com>
#####
#
# Set the path proper
path=( ~/bin /opt/local/bin 
/usr/local/bin /sbin /usr/sbin /usr/bin $path )

# Set language
export LC_ALL="en_US.UTF-8"

# if we're on server, re-enter screen.
if [[ $HOST == "teleport" ]] && [[ $TERM != "screen" ]]
then
    screen -r
    export FROM_SSH=
fi

# Preferred Applications ##########
export EDITOR=`which vim`
export PAGER=`which less`
export MANPAGER=$PAGER

# Aliases ####################
alias ls="ls -F"
alias screen="screen -U"

# Shell options ############

# make cd push the old directory to the dirstack
setopt auto_pushd
# complete as much of a completion until it gets ambiguous.
setopt list_ambiguous
# cycle through globbing matches like menu_complete
setopt glob_complete
# bash-like completion options
setopt no_auto_menu
setopt no_menu_complete
setopt auto_list

# append every single command to $HISTFILE immediately after
# hitting ENTER.
setopt append_history
# save extended history
setopt extended_history
# save a lot of history
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zshhistory


# Completion ###############
autoload -U compinit
compinit

# zmv
autoload zmv

# Enable caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Remove trailing slashes
zstyle ':completion:*' squeeze-slashes true

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Replace the default completion (files) with hosts, for some commands
hosts=(
	"$_etc_hosts[@]"
	"$_ssh_known_hosts[@]"

	localhost
      )
compdef _hosts ssh ping

# Prompt ###################

autoload colors && colors
CYAN=%{$fg[cyan]%}
GREEN=%{$fg[green]%}
DEFAULT=%{$fg[default]%}
PROMPT="${CYAN}%n@%m ${GREEN}%~ $DEFAULT> "

# Key Bindings ###############

# Use mostly emacs bindings
bindkey -e
# Fix the delete key
bindkey "^[[3~" delete-char
# Complete in the middle of some text ignoring the suffix. 
bindkey '^i' expand-or-complete-prefix

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# NaCl Stuff ################

# Setup NaCl root.
export NACL_SDK_ROOT=$HOME/Tools/nacl_sdk/pepper_31/
export NACL_SDK_BIN=$NACL_SDK_ROOT/toolchain/mac_x86_newlib/bin/
export NACL_DEBUG_ENABLE=1
export PPAPI_BROWSER_DEBUG=1
export NACL_PLUGIN_DEBUG=1
export NACL_PPAPI_PROXY_DEBUG=1
export PATH=$PATH:$NACL_SDK_ROOT/toolchain/mac_pnacl/bin

# GSUtil Stuff.
#export PATH=${PATH}:$HOME/Tools/gsutil

# Setup depot tools for Chrome-related projects.
export PATH=$PATH:$HOME/Tools/depot_tools

# Homebrew stuff
export PATH=/usr/local/homebrew/bin:$PATH

# Ruby path.
export PATH=/usr/local/homebrew/Cellar/ruby/1.9.3-p286/bin:$PATH

# Node path.
export PATH=$PATH:/usr/local/homebrew/share/npm/bin

# Chromium use ninja.
export GYP_GENERATORS=ninja

# P4 config for mac.
P4CONFIG='.p4config'

# Pebble development.
export PATH=$PATH:~/Tools/pebble-dev/PebbleSDK-2.0-BETA5/bin

# Go
export PATH=$PATH:/usr/local/homebrew/Cellar/go/1.2.1/libexec/bin

# Tex
export PATH=$PATH:/usr/texbin

# todo.txt
alias t=todo.sh

# Homebrew
export PATH=$HOME/homebrew/bin:$PATH

# Go AppEngine.
#export PATH=$PATH:$HOME/Tools/go_appengine/

# CITC support.
source /etc/bash_completion.d/g4d

# Alias for blaze-run.
alias blaze-run=/google/src/head/depot/google3/devtools/blaze/scripts/blaze-run.sh
