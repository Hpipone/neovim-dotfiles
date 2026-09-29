# Neovim my dotfiles/config. for now
## Requirement
- lazygit
- Nerd Font (for icons)

---

### install Nerd Font (required for icons)

This config uses Nerd Font icons everywhere: statusline & separators (lualine), file icons (nvim-web-devicons, mini.icons), completion kinds (lspkind), git signs (gitsigns), pickers (telescope), dashboard (snacks, anvim), UI frames (lspsaga). Without a Nerd Font in your terminal every icon shows up as a hollow box (tofu).

Recommended: **JetBrainsMono Nerd Font** — any Nerd Font v3 works, this is the one the config is tested with.

1. Manual (all OS): download `JetBrainsMono.zip` from https://www.nerdfonts.com/font-downloader or https://github.com/ryanoasis/nerd-fonts/releases, unzip, install the `.ttf` files.
2. Windows (winget):
```shell
winget install -e --id DEVCOM.JetBrainsMonoNerdFont
```
3. Windows (Scoop):
```shell
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```
4. macOS (Homebrew):
```shell
brew install --cask font-jetbrains-mono-nerd-font
```
5. Linux (user install, no sudo):
```shell
mkdir -p ~/.local/share/fonts
unzip JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
```
6. Arch Linux (pacman):
```shell
sudo pacman -S ttf-jetbrains-mono-nerd
```

Tip: icons look too wide? install the "Mono" variant (`JetBrainsMonoNerdFontMono`, family `JetBrainsMono Nerd Font Mono`) — symbols are cut to one cell.

### set the font in your terminal

Neovim cannot change the font by itself — it renders with whatever font the **terminal** uses, so select the Nerd Font in your terminal:

- **Konsole (KDE):** Settings → Edit Current Profile → Appearance → Font → `JetBrainsMono Nerd Font`
- **Windows Terminal:** `Ctrl+,` → select your profile → Appearance → Font face → `JetBrainsMono Nerd Font`
- **GNOME Terminal:** Preferences → your profile → Text → Custom font
- **kitty / Alacritty / WezTerm / foot / iTerm2:** set the config option for font family to `JetBrainsMono Nerd Font`

Restart the terminal (or open a new window) after changing it — sessions opened before the change keep the old font.

### verify icons

Linux / macOS (bash, zsh, fish):
```shell
printf '\uf449 | \ue0b0\n'
```

Windows PowerShell:
```powershell
"$([char]0xF449) | $([char]0xE0B0)"
```

Expected: the info icon (from `\uf449`) and the powerline arrow (from `\ue0b0`). Boxes instead? In order of likelihood:

1. Font not installed.
2. Font installed but not selected in the terminal.
3. Terminal session was opened before you changed the font → restart it.
4. Linux only: emoji icons need an emoji font → `sudo apt install fonts-noto-color-emoji` (Debian/Ubuntu).

---

### install lazygit

1. Windows Scoop
```shell
# Add the extras bucket
scoop bucket add extras

# Install lazygit
scoop install lazygit
```
2. Windows Chocolatey
```shell
choco install lazygit
```
3. Winget
```shell
winget install -e --id=JesseDuffield.lazygit
```

4. Termux
```shell
apt install lazygit
```

5. Ubuntu/Debian
```shell
sudo apt install lazygit
```

6. Fedora/Amazon Linux/CentOS
```shell
sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit
```

7. Arch Linux
```shell
sudo pacman -S lazygit
```

8. Homebrew
```shell
brew install lazygit
```
- this is dotfiles just copied pasted with my friend and other
