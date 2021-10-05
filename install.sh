#!/bin/bash

#######
# Zsh #
#######

mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.fzf.zsh" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sF "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

[ ! -d "$XDG_CONFIG_HOME/base16-shell" ] \
&& git clone https://github.com/chriskempson/base16-shell.git $XDG_CONFIG_HOME/base16-shell

########
# nvim #
########

mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/init.lua" "$XDG_CONFIG_HOME/nvim"

rm -rf "$XDG_CONFIG_HOME/nvim/lua"
ln -sF "$DOTFILES/nvim/lua" "$XDG_CONFIG_HOME/nvim"
rm -rf "$XDG_CONFIG_HOME/nvim/plugin"
ln -sF "$DOTFILES/nvim/plugin" "$XDG_CONFIG_HOME/nvim"
rm -rf "XDG_CONFIG_HOME/nvim/after"
ln -sF "$DOTFILES/nvim/after" "$XDG_CONFIG_HOME/nvim"
rm -rf "XDG_CONFIG_HOME/nvim/tools"
ln -sF "$DOTFILES/nvim/tools" "$XDG_CONFIG_HOME/nvim"
rm -rf "$XDG_CONFIG_HOME/nvim/my_snippets"
ln -sF "$DOTFILES/nvim/my_snippets" "$XDG_CONFIG_HOME/nvim"

#######
# git #
#######

mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/gitconfig" "$XDG_CONFIG_HOME/git/config"

########
# tmux #
########

mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ] \
&& git clone https://github.com/tmux-plugins/tpm \
"$XDG_CONFIG_HOME/tmux/plugins/tpm"

#######
# npm #
#######

[ ! -d "$XDG_CONFIG_HOME/nvm" ] \
&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#
# zathura
#
mkdir -p "$XDG_CONFIG_HOME/zathura"
ln -sf "$DOTFILES/zathura/zathurarc" "$XDG_CONFIG_HOME/zathura"

#####
# R #
#####

ln -sF "$DOTFILES/R" "$XDG_CONFIG_HOME/"
