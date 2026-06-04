#!/usr/bin/env bash
#
# install.sh — set up these ricing dotfiles on a fresh macOS machine.
#
# Safe to re-run (idempotent). Degrades gracefully: if a tool can't be installed
# or a permission is missing, that step is skipped with a warning instead of
# aborting — so it works on a locked-down / MDM-managed work laptop too.
#
# This is built for a machine WHERE SIP IS LEFT ENABLED. yabai therefore runs in
# basic tiling mode (no scripting addition): window tiling / focus / resize / gaps
# work, but moving windows across Spaces and opacity effects do not. See the notes
# printed at the end.
#
# Usage:
#   ./install.sh                  # full setup (asks before applying macOS defaults)
#   ./install.sh --yes            # assume "yes" to all prompts
#   ./install.sh --defaults-only  # only apply macOS defaults + dock, nothing else
#   ./install.sh --no-defaults    # skip macOS defaults + dock
#   ./install.sh --no-services    # don't start yabai/skhd/sketchybar/borders
#   ./install.sh --help
#
# Compatible with the stock macOS bash 3.2.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# ----------------------------------------------------------------------------
# What gets installed / linked. Edit these arrays to taste.
# ----------------------------------------------------------------------------

# Homebrew formulae. Window-manager tools live in third-party taps; the full
# tap/name form auto-taps on install.
BREW_FORMULAE=(
  stow
  alacritty
  tmux
  fzf
  neovim
  neofetch
  eza
  jq
  thefuck
  zsh-autosuggestions
  zsh-syntax-highlighting
  dockutil
  koekeishiya/formulae/yabai
  koekeishiya/formulae/skhd
  FelixKratz/formulae/sketchybar
  FelixKratz/formulae/borders
)

# Casks (fonts + GUI apps). Add any work/desktop apps you want auto-installed here.
BREW_CASKS=(
  font-jetbrains-mono-nerd-font
  # Examples — uncomment what you want the script to install:
  # brave-browser
  # obsidian
  # raycast
  # visual-studio-code
  # slack
  # zoom
)

# stow packages to deploy (each maps into $HOME). Personal stuff (emacs, nvim,
# the scripts package, kitty, clang) is intentionally left out.
STOW_PACKAGES=(
  alacritty
  yabai
  sketchybar
  karabiner
  tmux
  neofetch
  nvim
  zsh
  profile
  icons
)

# Individual scripts to symlink into ~/.scripts (the "scripts" package as a whole
# contains personal tooling, so we cherry-pick the generic ones only).
SCRIPTS_ALLOWLIST=(
  tmux-sessionizer
  cr
  update
  weather
  mov2gif
  ocrpdf
)

# Dock icons to pin, in order. Only apps that actually exist get added, so this
# list is safe even if some aren't installed on this machine.
DOCK_APPS=(
  "/Applications/Brave Browser.app"
  "/System/Applications/Preview.app"
  "/System/Applications/System Settings.app"
  "/System/Applications/Utilities/Activity Monitor.app"
  "/System/Applications/Calendar.app"
  "/Applications/Obsidian.app"
)

# Optional: set the desktop wallpaper. Point this at an image to enable it,
# e.g. WALLPAPER="$DOTFILES_DIR/wallpapers/Pictures/your-wallpaper.png"
WALLPAPER=""

# ----------------------------------------------------------------------------
# Output helpers
# ----------------------------------------------------------------------------
if [ -t 1 ]; then
  C_BLUE="\033[1;34m"; C_GREEN="\033[1;32m"; C_YELLOW="\033[1;33m"; C_RED="\033[1;31m"; C_RESET="\033[0m"
else
  C_BLUE=""; C_GREEN=""; C_YELLOW=""; C_RED=""; C_RESET=""
fi
section() { printf "\n${C_BLUE}==> %s${C_RESET}\n" "$1"; }
log()     { printf "    %s\n" "$1"; }
ok()      { printf "    ${C_GREEN}✓ %s${C_RESET}\n" "$1"; }
warn()    { printf "    ${C_YELLOW}! %s${C_RESET}\n" "$1"; }
err()     { printf "    ${C_RED}✗ %s${C_RESET}\n" "$1"; }

ASSUME_YES=0
confirm() {
  # confirm "question" -> returns 0 for yes
  [ "$ASSUME_YES" = "1" ] && return 0
  local reply
  printf "    %s [y/N] " "$1"
  read -r reply
  case "$reply" in [yY]|[yY][eE][sS]) return 0;; *) return 1;; esac
}

# ----------------------------------------------------------------------------
# Argument parsing
# ----------------------------------------------------------------------------
DO_PACKAGES=1; DO_STOW=1; DO_SCRIPTS=1; DO_DEFAULTS=1; DO_SERVICES=1
for arg in "$@"; do
  case "$arg" in
    --yes|-y)        ASSUME_YES=1 ;;
    --defaults-only) DO_PACKAGES=0; DO_STOW=0; DO_SCRIPTS=0; DO_SERVICES=0 ;;
    --no-defaults)   DO_DEFAULTS=0 ;;
    --no-services)   DO_SERVICES=0 ;;
    --help|-h)
      sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) err "unknown option: $arg (try --help)"; exit 1 ;;
  esac
done

# ----------------------------------------------------------------------------
# Preflight
# ----------------------------------------------------------------------------
if [ "$(uname -s)" != "Darwin" ]; then
  err "This script targets macOS only."; exit 1
fi

section "Plan"
log "Dotfiles dir : $DOTFILES_DIR"
[ "$DO_PACKAGES" = "1" ] && log "• install Homebrew packages"
[ "$DO_STOW" = "1" ]     && log "• stow configs: ${STOW_PACKAGES[*]}"
[ "$DO_SCRIPTS" = "1" ]  && log "• link scripts: ${SCRIPTS_ALLOWLIST[*]}"
[ "$DO_DEFAULTS" = "1" ] && log "• apply macOS defaults + dock"
[ "$DO_SERVICES" = "1" ] && log "• start yabai / skhd / sketchybar / borders"
log "Conflicting files are backed up to: $BACKUP_DIR"
echo
confirm "Proceed?" || { log "Aborted."; exit 0; }

# ----------------------------------------------------------------------------
# Prepare common dirs (so nothing errors on first shell launch)
# ----------------------------------------------------------------------------
section "Preparing directories"
mkdir -p "$HOME/.scripts" "$HOME/.cache/zsh" "$HOME/.cache/nvim" "$HOME/Downloads/Screenshots"
ok "ready"

# ----------------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------------
ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then return 0; fi
  for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$p" ]; then eval "$("$p" shellenv)"; return 0; fi
  done
  warn "Homebrew not found."
  if confirm "Install Homebrew now? (needs admin + network)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
      || { err "Homebrew install failed."; return 1; }
    for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      [ -x "$p" ] && eval "$("$p" shellenv)"
    done
  fi
  command -v brew >/dev/null 2>&1
}

brew_install_formula() {
  local f="$1" name
  name="$(basename "$f")"
  if brew list --formula "$name" >/dev/null 2>&1; then
    log "$name already installed"
  elif brew install "$f"; then
    ok "installed $name"
  else
    warn "could not install $name — skipping"
  fi
}

brew_install_cask() {
  local c="$1"
  if brew list --cask "$c" >/dev/null 2>&1; then
    log "$c already installed"
  elif brew install --cask "$c"; then
    ok "installed $c"
  else
    warn "could not install $c — skipping"
  fi
}

if [ "$DO_PACKAGES" = "1" ]; then
  section "Homebrew packages"
  if ensure_homebrew; then
    for f in "${BREW_FORMULAE[@]}"; do brew_install_formula "$f"; done
    for c in "${BREW_CASKS[@]}"; do brew_install_cask "$c"; done
  else
    warn "Skipping all package installs (no Homebrew). Configs will still be linked."
  fi
fi

# ----------------------------------------------------------------------------
# Stow (with conflict backup)
# ----------------------------------------------------------------------------
backup_conflicts() {
  local pkg="$1" src rel target
  while IFS= read -r -d '' src; do
    rel="${src#"$DOTFILES_DIR/$pkg/"}"
    target="$HOME/$rel"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
      mv "$target" "$BACKUP_DIR/$rel" && warn "backed up existing $target"
    fi
  done < <(find "$DOTFILES_DIR/$pkg" -type f ! -name '.DS_Store' ! -name 'nvim.log' -print0)
}

if [ "$DO_STOW" = "1" ]; then
  section "Linking configs with stow"
  if command -v stow >/dev/null 2>&1; then
    for pkg in "${STOW_PACKAGES[@]}"; do
      if [ ! -d "$DOTFILES_DIR/$pkg" ]; then warn "no package '$pkg' — skipping"; continue; fi
      backup_conflicts "$pkg"
      if (cd "$DOTFILES_DIR" && stow -R -t "$HOME" "$pkg" 2>/dev/null); then
        ok "stowed $pkg"
      else
        err "stow failed for $pkg (resolve conflicts in $HOME, then re-run)"
      fi
    done
  else
    err "stow not installed — cannot link configs. Install Homebrew + stow and re-run."
  fi
fi

# ----------------------------------------------------------------------------
# Scripts (selective symlink into ~/.scripts)
# ----------------------------------------------------------------------------
if [ "$DO_SCRIPTS" = "1" ]; then
  section "Linking scripts into ~/.scripts"
  for s in "${SCRIPTS_ALLOWLIST[@]}"; do
    src="$DOTFILES_DIR/scripts/.scripts/$s"
    if [ -e "$src" ]; then
      ln -sfn "$src" "$HOME/.scripts/$s" && ok "$s"
    else
      warn "missing script: $s"
    fi
  done
fi

# ----------------------------------------------------------------------------
# macOS defaults
# ----------------------------------------------------------------------------
apply_macos_defaults() {
  section "macOS defaults"

  # --- Dock ---
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock autohide-delay -float 9999      # permanent hide; to revert: defaults delete com.apple.dock autohide-delay
  defaults write com.apple.dock autohide-time-modifier -float 0
  defaults write com.apple.dock orientation -string left
  defaults write com.apple.dock tilesize -int 42
  defaults write com.apple.dock largesize -int 69
  defaults write com.apple.dock magnification -bool false
  defaults write com.apple.dock mineffect -string scale
  defaults write com.apple.dock minimize-to-application -bool false
  defaults write com.apple.dock show-process-indicators -bool true
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock mru-spaces -bool false          # don't auto-reorder Spaces (matters for yabai)
  for corner in wvous-tl-corner wvous-tr-corner wvous-bl-corner wvous-br-corner; do
    defaults write com.apple.dock "$corner" -int 1              # 1 = disabled
  done
  ok "Dock"

  # --- Appearance & input ---
  defaults write -g AppleInterfaceStyle -string Dark
  defaults write -g AppleAccentColor -int 5                     # purple
  defaults write -g AppleHighlightColor -string "0.968627 0.831373 1.000000 Purple"
  defaults write -g AppleShowScrollBars -string Always
  defaults write -g AppleShowAllExtensions -bool true
  defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write -g KeyRepeat -int 2
  defaults write -g InitialKeyRepeat -int 25
  defaults write -g ApplePressAndHoldEnabled -bool false        # key repeat for vim instead of accent popup
  ok "Appearance & keyboard"

  # --- Trackpad: tap to click ---
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write -g com.apple.mouse.tapBehavior -int 1
  defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
  ok "Trackpad"

  # --- Finder ---
  defaults write com.apple.finder AppleShowAllFiles -bool true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
  defaults write com.apple.finder NewWindowTarget -string PfHm
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
  ok "Finder"

  # --- Window-manager helpers (for yabai/sketchybar) ---
  defaults write -g _HIHideMenuBar -bool true                  # autohide menu bar (sketchybar replaces it)
  defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
  defaults write com.apple.WindowManager GloballyEnabled -bool false   # Stage Manager off
  ok "Window-manager helpers"

  # --- Screenshots ---
  defaults write com.apple.screencapture location -string "$HOME/Downloads/Screenshots"
  ok "Screenshots -> ~/Downloads/Screenshots"

  killall Dock >/dev/null 2>&1
  killall Finder >/dev/null 2>&1
  killall SystemUIServer >/dev/null 2>&1
}

setup_dock() {
  section "Dock icons"
  if ! command -v dockutil >/dev/null 2>&1; then
    warn "dockutil not installed — leaving dock icons as-is."
    return
  fi
  dockutil --no-restart --remove all "$HOME" >/dev/null 2>&1
  for app in "${DOCK_APPS[@]}"; do
    if [ -d "$app" ]; then
      dockutil --no-restart --add "$app" "$HOME" >/dev/null 2>&1 && ok "pinned $(basename "$app" .app)"
    else
      log "skip (not installed): $(basename "$app" .app)"
    fi
  done
  killall Dock >/dev/null 2>&1
}

set_wallpaper() {
  [ -n "$WALLPAPER" ] || return 0
  if [ -f "$WALLPAPER" ]; then
    osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER\"" \
      >/dev/null 2>&1 && ok "wallpaper set" || warn "could not set wallpaper"
  else
    warn "WALLPAPER not found: $WALLPAPER"
  fi
}

if [ "$DO_DEFAULTS" = "1" ]; then
  if confirm "Apply macOS defaults + dock now?"; then
    apply_macos_defaults
    setup_dock
    set_wallpaper
  else
    log "Skipped macOS defaults."
  fi
fi

# ----------------------------------------------------------------------------
# Services
# ----------------------------------------------------------------------------
if [ "$DO_SERVICES" = "1" ]; then
  section "Starting services"
  # yabai + skhd: use their OWN service manager. `--start-service` enables the
  # launchd agent AT LOGIN, loads, and starts it — more reliable than
  # `brew services` (which doesn't always register a never-started service for
  # login, so skhd ends up not enabled by default). We first tear down every
  # other variant (brew services + stale process + pid-lock) so two agents can't
  # fight over the lock ("could not lock pid-file! abort..").
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
      log "skip (not installed): $svc"
    fi
  done
  # sketchybar + borders: brew services is fine for these.
  if command -v brew >/dev/null 2>&1; then
    for svc in sketchybar borders; do
      if brew list --formula "$svc" >/dev/null 2>&1; then
        brew services restart "$svc" >/dev/null 2>&1 && ok "$svc" || warn "could not start $svc"
      else
        log "skip (not installed): $svc"
      fi
    done
  fi
fi

# ----------------------------------------------------------------------------
# Final notes
# ----------------------------------------------------------------------------
section "Done — a few manual steps"
cat <<'EOF'
    PERMISSIONS (yabai & skhd won't work until you grant these):
      • System Settings → Privacy & Security → Accessibility
          add & enable: yabai, skhd
      • System Settings → Privacy & Security → Input Monitoring
          add & enable: skhd

    SIP IS ENABLED on this machine, so yabai runs WITHOUT its scripting addition:
      WORKS    tiling, focus (alt+h/j/k/l), warp, resize, gaps, float, zoom
      WON'T    moving windows across Spaces (shift+alt+N), opacity, window borders
      Use native Spaces switching instead: System Settings → Keyboard → Keyboard
      Shortcuts → Mission Control → enable "Switch to Desktop 1..N" (Ctrl+Number).

    OTHER:
      • Some defaults (menu bar autohide, key repeat) fully apply after a logout.
        If the top menu bar doesn't autohide, toggle it once at:
        System Settings → Control Center → Automatically hide and show the menu bar → Always
      • First `nvim` launch bootstraps LazyVim plugins (needs network) — give it a minute.
      • Restart your terminal (or `exec zsh`) to pick up the new shell config.
      • Backed-up pre-existing files (if any) are in: ~/.dotfiles-backup/
EOF
ok "Setup complete."
