#!/usr/bin/env bash

pacman_apps=(
  # Essentials
  'git'                 # Version control
  'neovim'              # Text editor
  'thunar'              # Directory browser
  'tmux'                # Term multiplexer
  'fish'                # Terminal
  'kitty'               # Terminal emulator

  # CLI Tools
  'thefuck'             # Auto-correct miss-typed commands
  'zoxide'              # Better cd
  'lazygit'             # CLI Git tool
  'lf'                  # CLI directory browser

  # Programming
  'clang'               # CPP 

  # Audio 
  'blueman'
  'bluez'
  'pavucontrol'
  'pipewire-pulse'

  # Utils
  'brightnessctl'

  # Environments
  'hyprland-git'        # Window manager
  'waybar'              # Statusbar
  'dunst'               # Notification manager
  'grimblast'           # Screenshots
  'hyprpicker-git'      # Color picker
  'input-remapper-git'  # Input remapper
  'nwg-displays'        # Configure displays
  'networkmanager'
  'network-manager-applet'

  # Other
  'discord'        
  'firefox'       # Web browser
  'spotify'

  # CLI Fun
  'lolcat'
  'neofetch'
  'cava'
)

if [ "$EUID" -ne 0 ]; then
  exit 1
fi

echo -e "Starting install..."
  for app in ${pacman_apps[@]}; do
    if hash "${app}" 2> /dev/null; then
      echo -e "[Skipping] ${app} is already installed"
    elif [[ $(echo $(pacman -Qk $(echo $app | tr 'A-Z' 'a-z') 2> /dev/null )) == *"total files"* ]]; then
      echo -e "[Skipping] ${app} is already installed via Pacman"
    else
      echo -e "[Installing] Downloading ${app}..."
      sudo pacman -S ${app} --noconfirm
    fi
  done
fi

echo -e "Finished installing / updating Arch packages."
# EOF