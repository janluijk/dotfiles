#!/usr/bin/env bash

# Set global variables
DOTFILES_DIR="$HOME/.dotfiles"

function setup_dot_files () {
  echo -e "Setting up Symlinks"
  cd "${DOTFILES_DIR}"
  git -C 
}
function install_packages () {
  echo -e "\n Installing packages"
  arch_pkg_install_script = "${DOTFILES_DIR}/scripts/installs/arch-pacman.sh"
  chmod +x $arch_pkg_install_script
  $arch_pkg_install_script
}

setup_dot_files
install_packages