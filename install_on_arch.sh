#!/bin/sh

# Exit when command fails
set -o errexit

install_yay() {
  echo "Installing yay..."
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
}

installer()
{
  echo "Wellcome to dotfiles installer"

  echo "-------------------------------------------------------------------------------------------"
  if ! [ -x "$(command -v yay)" ]; then
    install_yay
  else
    echo "Yay already installed ..."
}

# Call installer function
installer
