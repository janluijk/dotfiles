#!/usr/bin/env bash

# Set global variables
DOTFILES_DIR="$HOME/dotfiles"
DOTBOT_DIR="lib/dotbot"
DOTBOT_BIN="bin/dotbot"

function setup_dot_files () {
  echo -e "Setting up Symlinks"
  cd "${DOTFILES_DIR}"
  git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
  git submodule update --init recursive "${DOTBOT_DIR}"
  chmod +x /lib/dotbot/bin/dotbot
  "${DOTFILES_DIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${DOTFILES_DIR}" -c "${SYMLINK_FILE}" "${@}"
}

function install_packages () {
  echo -e "\n Installing packages"
  arch_pkg_install_script = "${DOTFILES_DIR}/scripts/installs/arch-pacman.sh"
  chmod +x $arch_pkg_install_script
  $arch_pkg_install_script
}

setup_dot_files
install_packages