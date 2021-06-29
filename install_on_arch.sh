#!/bin/sh

# Exit when command fails
set -o errexit

install_alacritty()
{
  echo "Alacritty installing..."
  ! [ -x "$(command -v alacritty)" ] && sudo pacman -Sy alacritty
  [ -d "$HOME/.config/alacritty" ] && rm -rf ~/.config/alacritty
  cp -r ~/dotfiles/alacritty ~/.config/alacritty
}

install_zsh()
{
  if ! [ -x "$(command -v zsh)" ]; then
    echo "Zsh installing..."
    sudo pacman -Sy zsh

    # Set zsh as default shell
    echo "Set zsh as default shell"
    chsh -s $(which zsh)
  fi

  # Install oh-my-zsh
  if ! [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sudo curl -L http://install.ohmyz.sh | sh
  fi

  # Install zsh plugins
  echo "Installing zsh plugins"
  ! [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] && \
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  ! [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  # Copy config
  cp ~/dotfiles/oh-my-zsh/theme/custom.zsh-theme ~/.oh-my-zsh/custom/themes/custom.zsh-theme
  [[ -e "$HOME/.zshrc" ]] && rm ~/.zshrc
  cp ~/dotfiles/zshrc ~/.zshrc
}

install_neofetch()
{
  echo "Installing neofetch..."
  ! [ -x "$(command -v neofetch)" ] && sudo pacman -Sy neofetch

  # Copy config
  [ -d "$HOME/.config/neofetch" ] && rm -rf ~/.config/neofetch
  cp -r ~/dotfiles/neofetch ~/.config/neofetch
}

install_ranger()
{
  echo "Installing ranger..."
  ! [ -x "$(command -v ranger)" ] && sudo pacman -Sy ranger

  # Copy config
  [ -d "$HOME/.config/neofetch" ] && rm -rf ~/.config/neofetch
  cp -r ~/dotfiles/neofetch ~/.config/neofetch

}

# Installer
sudo clear

echo "---------------------------------------------------------------"
echo "Wellcome to dotfiles installer!"
echo "---------------------------------------------------------------"
sleep 0.7

# Cloning config
[ -d "$HOME/dotfiles" ] && rm -rf ~/dotfiles
git clone https://github.com/TaiK7/dotfiles ~/dotfiles
echo "---------------------------------------------------------------"

# Ask install alacritty
read -p "Do you like to install alacritty config? (Y/N): " answer
if [[ "$answer" != "${answer#[Yy]}" ]]; then
  install_alacritty
else
  echo "Install alacritty config cancel"
fi
echo "---------------------------------------------------------------"
sleep 0.7

# Ask install zsh
read -p "Do you like to install zsh config? (Y/N): " answer
if [[ "$answer" != "${answer#[Yy]}" ]]; then
  install_zsh
else
  echo "Install zsh config cancel"
fi
echo "---------------------------------------------------------------"
sleep 0.7

# Ask install neofetch
read -p "Do you like to install neofetch config? (Y/N): " answer
if [[ "$answer" != "${answer#[Yy]}" ]]; then
  install_yay
  install_neofetch
else
  echo "Install neofetch config cancel"

  # Remove neofetch line in zshrc
  if [ -e "$HOME/.zshrc" ]; then
    for (( i = 0; i < 3; i++ )); do
      sed '$d' ~/.zshrc
    done
  fi
fi
echo "---------------------------------------------------------------"
sleep 0.7

# Ask install ranger
read -p "Do you like to install ranger config? (Y/N): " answer
if [[ "$answer" != "${answer#[Yy]}" ]]; then
  install_yay
  install_ranger
else
  echo "Install ranger config cancel"
fi
echo "---------------------------------------------------------------"
sleep 0.7

# Remove dotfiles folder
rm -rf ~/dotfiles
echo "---------------------------------------------------------------"
sleep 0.7

echo "Install success."
echo "I recommend you also install my nvim config from here: https://github.com/TaiK7/nvim"
echo "Enjoy!"
sleep 0.7
