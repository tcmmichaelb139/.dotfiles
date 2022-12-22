# .dotfiles - Macos

Managed with stow

# Showcase

![desktop-1](./assets/desktop1.png)

# Packages/Applications
I will write descriptions and installation details in the future.

## alacritty

```bash
brew install alacritty
```

## ccls

```bash
gcc-12 -E -v -xc++ /dev/null
```

or

```bash
gcc -E -v -xc++ /dev/null
```

Find the part following "#include <...> search starts here:"

And put that in the ccls wrapper script with -isystem prepended

## clang-format

## emacs

### Installation

```bash
brew install emacs-plus --HEAD --with-modern-doom3-icon --with-no-titlebar
```

Native comp feels slower on M1 in my opinion.

### Post Installation

Emacs client

```bash
stow ~/.dotfiles/emacs
launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
```

### Aspell
```bash
mkdir -p ~/.emacs.d/.local/etc/ispell && touch ~/.emacs.d/.local/etc/ispell/english.pws
echo "personal_ws-1.1 en 0" > ~/.emacs.d/.local/etc/ispell/english.pws
```

## karabiner

## neovim

```bash
brew install lua-language-server
```

```bash
stow nvim
```

## scripts

## sketchybar

```bash
stow sketchybar
```

## Wallpaper

[](https://ign.schrodinger-hat.it/color-schemes) is amazing for converting wallpapers info a colorscheme.

## yabai

### Installation

```bash
brew install koekeishiya/formulae/yabai
brew services start yabai
brew install koekeishiya/formulae/skhd
brew services start skhd
```

(Copied from [yabai GitHub](https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)) and [skhd GitHub](https://github.com/koekeishiya/skhd))

## zsh
