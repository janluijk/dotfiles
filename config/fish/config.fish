set fish_greeting
set -gx EDITOR nvim

set -U fish_user_paths /home/jan/.local/bin $fish_user_paths

bind \cH backward-kill-word

# Aliases
alias vim=nvim

# Dotfiles
alias dotfiles='cd $HOME/dotfiles'

# Nvim config
alias vimrc='cd $HOME/dotfiles/config/nvim & nvim'

# To change alias, open this file
alias aliaschanger='nvim $HOME/dotfiles/config/fish/config.fish'

# Obsidian 
alias oo='cd $HOME/personal/vault/personal'

alias config='cd $HOME/dotfiles/config & nvim'

alias nvimfzf='nvim $(fzf)'

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
