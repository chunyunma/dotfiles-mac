# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

fpath=($ZDOTDIR/external $fpath)

source "$XDG_CONFIG_HOME/zsh/aliases"

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source "$ZDOTDIR/external/completion.zsh"

autoload -Uz prompt_purification_setup; prompt_purification_setup

# enable completion for pipx
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

# multiple options regarding history

setopt EXTENDED_HISTORY
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# allow comments in interactive shell
setopt INTERACTIVE_COMMENTS

# alias with hash table for quick navigation
hash -d c=$HOME/Documents/codingIsFun/
# hash -d b=$HOME/Documents/codingIsFun/datanarrator_sandbox/
hash -d r=$HOME/Documents/codingIsFun/rrr/

# alias for quick navigation
alias config='nvim -S ~/.config/nvim/session/config.vim'
alias zk='nvim -S ~/.config/nvim/session/zk.vim'
alias teaching='nvim -S ~/.config/nvim/session/teaching.vim'
alias bmd='nvim -S ~/.config/nvim/session/baby-modern-dive.vim'

# vi mode in zsh
bindkey -v
export KEYTIMEOUT=1

# beam for INSERT mode and block for NORMAL mode in zsh
autoload -Uz cursor_mode && cursor_mode

# Edit commands in nvim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Quickly jump to a parent directory
source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    source /usr/local/opt/fzf/shell/completion.zsh
    source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

# Clearing the shell is now done with CTRL+g 
# because c-l is used to navigate panes in tmux
bindkey -r '^l'
bindkey -r '^g'
bindkey -s '^g' 'clear\n'


#*****************************************************************************
# configure pyenv
#*****************************************************************************

typeset -U PATH path
PATH="$HOME/.pyenv/bin:$PATH"
# The next two lines would automatically activate/deactivate \
# virtualenvs on entering/leaving directories
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Including the venv in the shell prompt when active
# Disable the message "pyenv-virtualenv: prompt changing..."
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# # Pre-fix prompt with $(pyenv version) when active
# export BASE_PROMPT=$PS1
# function updatePrompt {
#     if [[ "$(pyenv version-name)" != "system" ]]; then
#         export PS1="($(pyenv version-name)) "$BASE_PROMPT
#     else
#         export PS1=$BASE_PROMPT
#     fi
# }
# export PROMPT_COMMAND='updatePrompt'
# precmd() { eval '$PROMPT_COMMAND' }

# Another version, would not work 
# if I set PYENV_VIRTUALENV_DISABLE_PROMPT=1
# precmd() {
#     if [[ -n $PYENV_SHELL ]]; then
#         local version
#         version=${(@)$(pyenv version)[1]}
#         if [[ $version = system ]]; then
#             unset VIRTUAL_ENV
#         else
#             VIRTUAL_ENV=$version
#         fi
#     fi
# }


# include pipx
export PATH=$PATH:/Users/chunyun/.local/bin

# include homebrew's sbin
export PATH=$PATH:/usr/local/sbin/

# set up virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/codingIsFun/python
export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
# Tried the following to replace the previous line, did not succeed
# export VIRTUALENVWRAPPER_PYTHON=$(pyenv root)/shims/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/virtualenv
source $HOME/.local/bin/virtualenvwrapper.sh

#*****************************************************************************
# Set R environment
#*****************************************************************************
# prefer the alias method over the PATH method
export PATH="$PATH:/Library/Frameworks/R.framework/Resources"
alias R '/Library/Frameworks/R.framework/Versions/Current/Resources/bin/R --no-save --no-restore-data'
# alias R='R --no-save --no-restore-data'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# echo 'Sys.setlocale(category="LC_ALL", locale = "en_US.UTF-8")'

#*****************************************************************************
# set Go env
#*****************************************************************************
export GOPATH=~/Documents/codingIsFun/go
typeset -U PATH path
PATH=$PATH:$(go env GOPATH)/bin

#*****************************************************************************
# set ruby env
#*****************************************************************************
export PATH="$PATH:/usr/local/opt/ruby/bin:$HOME/.gem/ruby/2.6.0/bin/"

# Set breakpoint() in Python to automatically call pudb
# Decided not to use this approach
# Instead, will explicitly call python -m pudb when needed
# export PYTHONBREAKPOINT="pudb.set_trace"

#*****************************************************************************
# Base16 Shell for aesthetics
#*****************************************************************************
BASE16_SHELL="$XDG_CONFIG_HOME/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#*****************************************************************************
############ fzf and ripgrep #############
#*****************************************************************************
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
source $ZDOTDIR/.fzf.zsh
export FZF_COMPLETION_TRIGGER='~~'
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs \
		-g "!{.git,renv}/*" 2> /dev/null'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

#################################################################
# wiki note related setting
#################################################################
export ZK_DIR=/Users/chunyun/Documents/zk/
alias ctags='/usr/local/bin/ctags'

#
# install node version manager to prepare node.js install
#
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

source "$ZDOTDIR/external/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
