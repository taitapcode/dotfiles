#!/bin/bash

# Clean terminal
sudo clean

# Install dependencies
echo "Install dependencies..."
sudo pacman -Sy zsh git base-devel zoxide fzf exa bat ranger neovim github-cli

# Install A.U.R helper
echo "Install Paru A.U.R helper..."
git clone https://aur.archlinux.org/paru.git ~/paru
cd ~/paru
makepkg -si

# Clean up after install paru
cd
rm -rf ~/paru
paru -c

# Change default shell to zsh
echo "Set default shell to zsh..."
chsh -s $(which zsh)

# Install Oh My Zsh
echo "Install Oh-My-Zsh..."
export ZDOTDIR="$HOME/.zsh"
zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone config
echo "Clone config repo..."
git clone --depth=1 https://github.com/noname0203/dotfiles -b wsl ~/.dotfiles
cp ~/.dotfiles/.config ~ -r
cp ~/.dotfiles/.zsh/* ~ -r

# Install zsh plugins
echo "Install zsh-vi-mode, zsh-autosuggestions, fast-syntax-highlighting..."
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode

git clone https://github.com/zsh-users/zsh-autosuggestions \ 
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

echo "Login to github..."
gh auth login

cd
echo "Make sure you use Nerd Font for icon: https://www.nerdfonts.com/font-downloads"
echo "Before reset, make sure you have 'export ZDOTDIR=\$HOME/.zsh' in '/etc/zsh/zshenv'"

exit 0
