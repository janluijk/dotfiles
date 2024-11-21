#!/usr/bin/env bash

# Set global variables
DOTFILES_DIR="$HOME/dotfiles"
DOTBOT_DIR="lib/dotbot"
DOTBOT_BIN="bin/dotbot"
SYMLINK_FILE="symlinks.yaml"

function setup_dot_files () {
  echo -e "Setting up environment variables"
  export XDG_CONFIG_HOME="${HOME}/.config"
  export XDG_DATA_HOME="${HOME}/.local/share"
  export XDG_BIN_HOME="${HOME}/.local/bin"

  echo -e "Setting up Symlinks"
  cd "${DOTFILES_DIR}"
  git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
  git submodule update --init --recursive "${DOTBOT_DIR}"
  chmod +x lib/dotbot/bin/dotbot
  "${DOTFILES_DIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${DOTFILES_DIR}" -c "${SYMLINK_FILE}" "${@}"
}

function install_packages () {
  echo -e "\n Installing packages"
  arch_pkg_install_script="${DOTFILES_DIR}/scripts/arch-pacman.sh"
  chmod +x ${arch_pkg_install_script}
  sudo ${arch_pkg_install_script}
}

function post_install_config () {
  echo -e "Enable ly desktop manager"
  sudo systemctl enable ly.service

  echo -e "\n Setting fish as default shell"
  chsh -s /bin/fish

  echo -e "\n Getting wallpapers"
  mkdir -p ~/pictures/wallpapers/
  cp -r ./wallpapers/* ~/pictures/wallpapers/
}

setup_dot_files
copy_scripts
install_packages
post_install_config
