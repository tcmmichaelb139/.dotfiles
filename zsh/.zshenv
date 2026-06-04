ZDOTDIR=$HOME/.config/zsh
if [ -f "$HOME/.zshenv2" ]; then
    source "$HOME/.zshenv2"
fi
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
