## Screenshot
<img align="center" src="screenshot.png"/>

## Installation for arch linux

> Requirement: [Nerd font](https://www.nerdfonts.com/font-downloads) - I suggest using Fira Code NF Regular

1. Install some dependences
```bash
sudo pacman -Sy git lazygit base-devel zoxide fzf exa bat ranger neovim github-cli unzip fish fisher fd
```

2. Set fish as default shell
```bash
chsh -s /bin/fish
```

3. Install A.U.R helper
```
git clone https://aur.archlinux.org/paru.git ~/paru
cd ~/paru
makepkg -si
```

4. Install for tmux plugins
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-sensible ~/.config/tmux/plugins/tmux-sensible
git clone https://github.com/dracula/tmux ~/.config/tmux/plugins/tmux
```

5. Clone config from github
```bash
git clone --depth=1 https://github.com/noname0203/dotfiles -b wsl ~/.dotfiles
cp ~/.dotfiles/.config ~ -r
cp ~/dotfiles/.tmux.conf ~
```
