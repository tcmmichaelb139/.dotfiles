# .dotfiles - Macos

Managed with stow

# Showcase

![Obsidian, Neovim, Neofetch Desktop](./assets/desktop-full.png)
![Neovim Desktop](./assets/desktop-nvim.png)
![Blank Desktop](./assets/desktop-blank.png)

# Macos Settings

## Permanently Hide Dock

```bash
defaults write com.apple.dock autohide-delay -float 9999; killall Dock
```

# Packages/Applications

I will write descriptions and installation details in the future.

## alacritty

```bash
brew install alacritty
stow alacritty
```

## brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Use `ibrew` to install packages with Rosetta 2

## ccls

```bash
brew install ccls
```

```bash
gcc-12 -E -v -xc++ /dev/null
```

or

```bash
gcc -E -v -xc++ /dev/null
```

Find the part following "#include <...> search starts here:"

And put that in the ccls wrapper script with -isystem prepended

## clang

```bash
stow clang
```

<details>
<summary> Extra Setup for M1 </summary>

If you are getting the response (in nvim): `In included file: __float128 is not supported on this target`

Comment out the lines in `/opt/homebrew/Cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin22/12/include/stddef.h`

```cpp
#if defined(__i386__) || (__APPLE__ && __aarch64__)
  __float128 __max_align_f128 __attribute__((__aligned__(__alignof(__float128))));
#endif
```

</details>

## emacs

### Installation

```bash
brew install emacs-plus --HEAD --with-modern-doom3-icon --with-no-titlebar
```

Native comp feels slower on M1 in my opinion.

### Post Installation

Emacs client

```bash
stow emacs
launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
```

### Aspell

```bash
mkdir -p ~/.emacs.d/.local/etc/ispell && touch ~/.emacs.d/.local/etc/ispell/english.pws
echo "personal_ws-1.1 en 0" > ~/.emacs.d/.local/etc/ispell/english.pws
```

## Fonts

```bash
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

## karabiner

Settings:

- (right) cmd + hjkl (arrow keys)
- cmd + h (disables the default action)
- cmd + m (disables the default action)

```bash
stow karabiner
```

## Music

```bash
brew install spotify
```

## neovim

```bash
brew install neovim --HEAD

brew install tree-sitter node git llvm gcc@12 deno
```

```bash
stow nvim
```

## Obsidian

Theme: [tcmmichaelb139/obsidian-tokyonight](https://github.com/tcmmichaelb139/obsidian-tokyonight)

## OpenOffice

```bash
brew install --cask openoffice
```

## scripts

```bash
stow scripts
```

- `mdbg` Scrapes [mdbg.net](https://www.mdbg.net/chinese/dictionary) for the strokes and puts them into Anki
- `cr` Compiles and runs cpp
- `ccls` ccls helper

## sketchybar

```bash
stow sketchybar
```

## tmux

I don't really use tmux :/ (im trying to use it more tho)

Prefix: `C-\`

```bash
brew install tmux fzf
mkdir -p ~/.config/tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
stow tmux
```

## Wallpaper

<https://ign.schrodinger-hat.it/color-schemes> is amazing for converting wallpapers info a colorscheme.

Also check out [siddrs/wallpapers](https://github.com/siddrs/wallpapers) for Tokyo Night themed wallpapers

## yabai

### Installation

```bash
brew install koekeishiya/formulae/yabai
brew services start yabai
brew install koekeishiya/formulae/skhd
brew services start skhd
```

(Copied from [yabai GitHub](<https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)>) and [skhd GitHub](https://github.com/koekeishiya/skhd))

## zsh

```bash
stow zsh
```
