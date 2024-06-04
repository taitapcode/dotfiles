## Installation for arch linux distro

### 1. Install packages with pacman

```bash
sudo pacman -Sy git lazygit zoxide fzf eza fd bat ranger neovim github-cli stow base-devel tmux
```

### 2. Install AUR helper (yay)

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### 3. Install AUR packages

```bash
yay -S tmuxinator ttf-delugia-code
```

### 2. Set fish as default shell

```bash
chsh -s $(which fish)
```

### 3. Clone some repos

```bash
git clone https://github.com/taitapcode/dotfiles.git -b wsl ~/dotfiles
git clone https://github.com/oh-my-fish/oh-my-fish ~/.local/share/omf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Setup your config files

```bash
cd ~/dotfiles
stow .
```

### 5. Install `omf plugins` and set fish theme

> [!NOTE]
> You have to refresh your fish shell before using `omf` command with `fish` command

```bash
omf install bang-bang robbyrussell https://github.com/kidonng/zoxide.fish https://github.com/PatrickF1/fzf.fish
omf theme robbyrussell
fish
```
