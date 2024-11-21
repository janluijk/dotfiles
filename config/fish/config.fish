set fish_greeting
set -gx EDITOR nvim

bind \cH backward-kill-word

# Aliases
alias vim=nvim

# Dotfiles
alias dotfiles='cd $HOME/dotfiles & nvim'

# Nvim config
alias vimrc='cd $HOME/dotfiles/config/nvim & nvim'

# To change alias, open this file
alias aliaschanger='nvim $HOME/dotfiles/config/fish/config.fish'

# Obsidian 
alias oo='cd $HOME/personal/vault/personal'

alias config='cd $HOME/dotfiles/config & nvim'

starship init fish | source
