#!/bin/sh

# Exit when command fails
set -o errexit

ask_install_yay()
{
  echo "Installing yay..."
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
}

ask_install_alacritty()
{
  echo "Alacritty not found..."
  read -p "Do you want to install alacritty?(Y/N): " answer
  if [[ "$answer" != "${answer#[Yy]}" ]]; then
    yay -Sy nerd-fonts-cascadia-code
    sudo pacman -Sy alacritty
  fi
}

install_zsh()
{
  echo "Installing zsh"
  sudo pacman -Sy zsh

  echo "Set zsh as default shell"
  chsh -s $(which zsh)

  echo "Install oh-my-zsh"
  sudo curl -L http://install.ohmyz.sh | sh

  echo "Install zsh autosuggestions plugin"
  git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}

installer()
{
  sudo clear

  # Wellcome
  echo "Wellcome to dotfiles installer"
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7
  # Install yay

  if ! [ -x "$(command -v yay)" ]; then
    ask_install_yay
  else
    echo "Yay already installed ..."
  fi
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7

  # Install alacritty
  if ! [ -x "$(command -v alacritty)" ]; then
    ask_install_alacritty
  else
    echo "Alacritty already installed ..."
  fi
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7

  # Install neofetch
  if ! [ -x "$(command -v neofetch)" ]; then
    echo "Installing neofetch..."
    sudo pacman -Sy neofetch
  else
    echo "Neofetch already installed ..."
  fi
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7

  # Install ranger
  if ! [ -x "$(command -v ranger)" ]; then
    echo "Installing ranger..."
    sudo pacman -Sy ranger
  else
    echo "Neofetch already installed ..."
  fi
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7

  # Install zsh
  if ! [ -x "$(command -v zsh)" ]; then
    install_zsh
  else
    echo "Zsh already installed ..."

    # Install zsh autosuggestions plugin
    if ! [ -e "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
      echo "Installing zsh autosuggestions plugin..."
      git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi
  fi
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7


  # Clone config
  echo "Cloning config"
  # git clone https://github.com/Tai-Github/dotfiles
  # [ -d "$HOME/.config/alacritty" ] && rm -rf ~/.config/alacritty
  # cp -r
  echo "-------------------------------------------------------------------------------------------"
  sleep 0.7

  echo "Install success."
  echo "I recommend you also install my nvim config from here: https://github.com/TaiK7/nvim"
  echo "Enjoy!"
  sleep 0.7
}

# Call installer function
installer
