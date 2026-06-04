#!/usr/bin/env bash
#
# update.sh — apply ONLY the changes since the first install, so you don't have
# to re-run the whole thing. It:
#   1) deploys the nvim (LazyVim) config
#   2) fixes the skhd/yabai duplicate-service crash loop (single service per tool)
#
# It does NOT re-apply macOS defaults, the dock, or re-stow your other configs.
# Safe to re-run.
#
# Usage:
#   bash update.sh
#   DOTFILES_DIR=/path/to/your/.dotfiles bash update.sh   # if yours isn't at ~/.dotfiles

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

if [ -t 1 ]; then C_B="\033[1;34m"; C_G="\033[1;32m"; C_Y="\033[1;33m"; C_R="\033[1;31m"; C_0="\033[0m"
else C_B=""; C_G=""; C_Y=""; C_R=""; C_0=""; fi
section() { printf "\n${C_B}==> %s${C_0}\n" "$1"; }
ok()   { printf "    ${C_G}✓ %s${C_0}\n" "$1"; }
warn() { printf "    ${C_Y}! %s${C_0}\n" "$1"; }
err()  { printf "    ${C_R}✗ %s${C_0}\n" "$1"; }
log()  { printf "    %s\n" "$1"; }

[ "$(uname -s)" = "Darwin" ] || { err "macOS only."; exit 1; }

# Pick up Homebrew if it's installed but not on PATH (e.g. fresh non-login shell)
if ! command -v brew >/dev/null 2>&1; then
  for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$p" ] && eval "$("$p" shellenv)" && break
  done
fi

# ----------------------------------------------------------------------------
# 1) nvim config
# ----------------------------------------------------------------------------
section "Deploying nvim config"

# Put the nvim package where the rest of your dotfiles live so the symlink is
# stable; fall back to stowing from this folder if ~/.dotfiles isn't there.
if [ -d "$DOTFILES_DIR" ]; then
  cp -R "$SELF_DIR/nvim" "$DOTFILES_DIR/" && ok "copied nvim into $DOTFILES_DIR"
  STOW_FROM="$DOTFILES_DIR"
else
  warn "no $DOTFILES_DIR — linking from this folder (keep it around, or re-run with DOTFILES_DIR set)"
  STOW_FROM="$SELF_DIR"
fi

# Back up any existing real ~/.config/nvim before linking
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  BK="$HOME/.dotfiles-backup/nvim-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$(dirname "$BK")"
  mv "$HOME/.config/nvim" "$BK" && warn "backed up existing ~/.config/nvim -> $BK"
fi

mkdir -p "$HOME/.cache/nvim"

# Make sure neovim itself is installed
if command -v brew >/dev/null 2>&1 && ! command -v nvim >/dev/null 2>&1; then
  brew install neovim && ok "installed neovim" || warn "could not install neovim"
fi

if command -v stow >/dev/null 2>&1; then
  if (cd "$STOW_FROM" && stow -R -t "$HOME" nvim 2>/dev/null); then
    ok "nvim config linked (~/.config/nvim)"
  else
    err "stow failed for nvim — check for conflicts in ~/.config/nvim"
  fi
else
  err "stow not installed; run the main install.sh first"
fi

# ----------------------------------------------------------------------------
# 2) Fix skhd / yabai services (single agent per tool)
# ----------------------------------------------------------------------------
section "Fixing window-manager services"
# yabai + skhd: enable via their OWN service manager so they actually start AT
# LOGIN (brew services doesn't always register them, which is why skhd wasn't
# enabled by default). Tear down every other variant first so two launchd agents
# can't fight over the pid-lock ("could not lock pid-file! abort..").
for svc in yabai skhd; do
  if command -v "$svc" >/dev/null 2>&1; then
    brew services stop "$svc" >/dev/null 2>&1
    "$svc" --stop-service >/dev/null 2>&1
    pkill -x "$svc" >/dev/null 2>&1
    rm -f "/tmp/${svc}_$USER.lock" >/dev/null 2>&1
    sleep 1
    "$svc" --install-service >/dev/null 2>&1
    if "$svc" --start-service >/dev/null 2>&1; then
      ok "$svc (enabled at login)"
    else
      warn "could not start $svc"
    fi
  else
    warn "$svc not installed — run the main install.sh first"
  fi
done
if command -v brew >/dev/null 2>&1; then
  for svc in sketchybar borders; do
    brew list --formula "$svc" >/dev/null 2>&1 && brew services restart "$svc" >/dev/null 2>&1 && ok "$svc"
  done
fi

# ----------------------------------------------------------------------------
section "Done"
cat <<'EOF'
    • First `nvim` launch bootstraps LazyVim plugins (needs network) — give it a minute.
    • If skhd still doesn't respond: System Settings → Privacy & Security →
      Accessibility (add skhd) and Input Monitoring (add skhd), then re-run this.
    • Space hotkeys (alt+N / shift+alt+N) need yabai's scripting addition, which
      needs SIP disabled — with SIP on, use native Ctrl+Number to switch Spaces.
EOF
ok "Update complete."
