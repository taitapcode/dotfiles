## Installation for arch linux distro

> [!NOTE]
> Make sure you installed `git`

### Clone repositories

```bash
git clone https://github.com/taitapcode/dotfiles.git ~/dotfiles
git clone https://github.com/oh-my-fish/oh-my-fish ~/.local/share/omf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Install packages with pacman

```bash
sudo pacman -Sy - < ~/dotfiles/pkgslist.txt
```

### Install AUR helper (yay)

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Install AUR packages

```bash
yay -S - < ~/dotfiles/aur-pkgslist.txt
```

### Set fish as default shell

```bash
chsh -s $(which fish)
```

### Setup your config files

```bash
cd ~/dotfiles
stow .
fish
```

### Install `omf plugins` and set fish theme

> [!NOTE]
> You have to refresh your fish shell before using `omf` command with `fish` command

```bash
omf install bang-bang robbyrussell https://github.com/kidonng/zoxide.fish https://github.com/PatrickF1/fzf.fish
omf theme robbyrussell
fish
```
