##########
# .zshrc for >=zsh-4.2.3
#   written by Boris Smus <boris@smus.com>
#####
#
# Set the path proper
path=( ~/bin /opt/local/bin /usr/local/bin /sbin /usr/sbin /usr/bin $path )

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
export NACL_SDK_ROOT=$HOME/Tools/nacl_sdk/pepper_46/
export NACL_SDK_BIN=$NACL_SDK_ROOT/toolchain/mac_x86_newlib/bin/
export NACL_DEBUG_ENABLE=1
export PPAPI_BROWSER_DEBUG=1
export NACL_PLUGIN_DEBUG=1
export NACL_PPAPI_PROXY_DEBUG=1
export PATH=$PATH:$NACL_SDK_ROOT/toolchain/mac_pnacl/bin

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

# Homebrew
export PATH=$HOME/homebrew/bin:$PATH

# Bagpipe for p4 access on mac.
if [[ `uname` != 'Linux' ]]
then
  BAGPIPE_SETUP=$HOME/.bagpipe/setup.sh
  if [[ -f $BAGPIPE_SETUP ]]
  then
    . $BAGPIPE_SETUP $HOME/.bagpipe smus.sea
  fi
fi

# Alias for blaze-run.
alias blaze-run=/google/src/head/depot/google3/devtools/blaze/scripts/blaze-run.sh

# TensorFlow development.
export PATH=/usr/local/cuda/bin:$PATH
export CUDA_HOME=/usr/local/cuda

# Updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/home/smus/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/google/home/smus/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/smus/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/smus/Downloads/google-cloud-sdk/path.zsh.inc'; fi


# For Linux, a way to load npm without having to go through apt-get.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -f /Users/smus/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/smus/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

# Mac SrcFS completion.
SRCFS_COMPLETION=/Library/GoogleCorpSupport/srcfs/shell_completion/enable_completion.sh
if [ -f $SRCFS_COMPLETION ]; then
  source $SRCFS_COMPLETION
fi

# Handy aliases to do current work.
alias cda="cd /google/src/cloud/smus/albacore/google3"

# Easier batch renaming.
autoload -U zmv
alias mmv='noglob zmv -W'

export USB_DEVFS_PATH=/dev/bus/usb

# For google app credentials.
#export GOOGLE_APPLICATION_CREDENTIALS=$HOME/babelfish-454519da7006.json

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Cerebra project path.
alias cdc="cd ~/Projects/cerebra"

# Windows emulator stuff.
export WINEARCH=win32
export WINEPREFIX=~/.wine_d2
alias d2="cd ~/.wine_d2/drive_c/Program\ Files/Diablo\ II && wine game.exe -w -3dfx -nofixaspect"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/boris/.nvm/versions/node/v13.10.1/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/boris/.nvm/versions/node/v13.10.1/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

# Support for Dart.
export PATH=/usr/lib/google-dartlang/bin:${PATH}

# On Linux, alias open to nautilus.
if [[ `uname` == 'Linux' ]]
then
  alias open='nautilus'
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/smus/Tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/smus/Tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/smus/Tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/smus/Tools/google-cloud-sdk/completion.zsh.inc'; fi

alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

path=( ~/homebrew/anaconda3/bin $path )

source ~/.zsh_secrets
