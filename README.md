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

## brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Use `ibrew` to install packages with Rosetta 2

```bash
ibrew install gcc --HEAD
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

## clang

```bash
stow clang
```

If you are getting the response: `In included file: __float128 is not supported on this target`

Comment out the lines in `/opt/homebrew/Cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin22/12/include/stddef.h`

```cpp
#if defined(__i386__) || (__APPLE__ && __aarch64__)
  __float128 __max_align_f128 __attribute__((__aligned__(__alignof(__float128))));
#endif
```

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
stow nvim
```

```bash
brew install neovim --HEAD

brew install tree-sitter node git llvm gcc@12
```

## scripts

```bash
stow scripts
```

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

(Copied from [yabai GitHub](<https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)>) and [skhd GitHub](https://github.com/koekeishiya/skhd))

## zsh
