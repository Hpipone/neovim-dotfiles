# Neovim dotfiles

## Requirements

- Neovim 0.11 or newer (tested on 0.12.5)
- git
- ripgrep and fd (picker search)
- lazygit
- Nerd Font v3 (icons)

## Install config

```shell
git clone https://github.com/Hpipone/neovim-dotfiles.git ~/.config/nvim
nvim
```

Lazy.nvim installs the plugins automatically on first start.

Update an existing install:

```shell
git -C ~/.config/nvim pull
nvim --headless "+Lazy! sync" +qa
```

## Install Neovim

Arch Linux:

```shell
sudo pacman -S neovim
```

Debian/Ubuntu:

```shell
sudo apt update
sudo apt install neovim
```

Fedora:

```shell
sudo dnf install neovim
```

macOS:

```shell
brew install neovim
```

Windows (PowerShell):

```powershell
winget install -e --id Neovim.Neovim
```

Termux:

```shell
pkg install neovim
```

## Install tools

Arch Linux:

```shell
sudo pacman -S git curl unzip ripgrep fd lazygit
```

Debian/Ubuntu:

```shell
sudo apt update
sudo apt install git curl unzip ripgrep fd-find lazygit
```

Fedora:

```shell
sudo dnf install git curl unzip ripgrep fd-find lazygit
```

macOS:

```shell
brew install git curl ripgrep fd lazygit
```

Windows (PowerShell):

```powershell
winget install -e --id Git.Git
winget install -e --id BurntSushi.ripgrep.MSVC
winget install -e --id sharkdp.fd
winget install -e --id JesseDuffield.lazygit
```

Termux:

```shell
pkg install git curl unzip ripgrep fd lazygit
```

## Install Nerd Font

Linux (user install, no sudo):

```shell
mkdir -p ~/.local/share/fonts
curl -fLo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
rm /tmp/JetBrainsMono.zip
```

Arch Linux:

```shell
sudo pacman -S ttf-jetbrains-mono-nerd
```

macOS:

```shell
brew install --cask font-jetbrains-mono-nerd-font
```

Windows (PowerShell):

```powershell
winget install -e --id DEVCOM.JetBrainsMonoNerdFont
```

Windows (Scoop):

```powershell
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```

Set the terminal font to `JetBrainsMono Nerd Font`, then restart the terminal.
Kitty example:

```shell
mkdir -p ~/.config/kitty
printf 'font_family JetBrainsMono Nerd Font\n' >> ~/.config/kitty/kitty.conf
```

Verify the font:

```shell
printf '\uf449 | \ue0b0\n'
```

Expected output: an info icon and a powerline arrow.

## Changes

- Notifications, picker, and lazygit use Snacks. `nvim-notify`, Telescope keymaps, and the ToggleTerm lazygit wrapper were removed.
- Python DAP no longer depends on Mason. It uses `python3` unless Mason provides `debugpy`.
- ESLint linting detects flat config and legacy `.eslintrc` files.
