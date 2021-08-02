#!/bin/bash

# Clean terminal
sudo clean

# Install dependencies
echo "Install dependencies..."
sudo pacman -Sy xorg xorg-xinit git xwallpaper chromium ranger alsa-utils zsh ibus sxiv mpv

# Install A.U.R helper
echo "Install A.U.R helper..."
git clone https://aur.archlinux.org/yay-git
cd yay-git && makepkg -si
cd .. && rm -rf yay-git

# Install A.U.R dependencies
echo "Install A.U.R dependencies..."
yay -S picom-jonaburg-git nerd-fonts-fira-code ibus-bamboo

# Zsh init
echo "Set default shell to zsh..."
chsh -s $(which zsh)

# Clone config
echo "Clone config repo..."
git clone --depth=1 https://github.com/TaiK7/dotfiles ~/.dotfiles
cp ~/.dotfiles/.config ~ -r
cp ~/.dotfiles/.local ~ -r
cp ~/.dotfiles/.icons ~ -r

# Install dwm
echo "Install dwm"
cd ~/.config/dwm/
sudo make install clean

# Install st terminal
echo "Install st terminal"
cd ~/.config/st/
sudo make install clean

# Install zsh plugins
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git \
  ~/.config/zsh/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.config/zsh/plugins/zsh-syntax-highlighting

echo "Befor restart, make sure you have 'export ZDOTDIR=\$HOME/.config/zsh'"

exit 0
