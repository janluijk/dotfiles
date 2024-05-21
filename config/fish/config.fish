set fish_greeting
set -gx EDITOR nvim

alias vim=nvim

# Dotfiles
alias dotfiles='cd $HOME/dotfiles/config'

# Nvim config
alias vimrc='cd $HOME/dotfiles/config/nvim & nvim'

# To change alias, open this file
alias aliaschanger='nvim $HOME/dotfiles/config/fish/config.fish'

# Prints my wallpapers directory
alias mywallpapers='cd $HOME/pictures/wallpapers'

# Prints screenshots directory
alias myscreenshots='cd $HOME/pictures/screenshots'

# Obsidian 
alias oo='cd $HOME/personal/vault/personal'

starship init fish | source
