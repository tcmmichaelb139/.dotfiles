#!/bin/sh
# Claude Code statusLine command
# Mirrors the zsh PROMPT: [blue]dir [yellow]>[red]>[magenta]> [cyan]branch
# Also shows: context used %, weekly (7-day) usage %, and current permission mode

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
dir=$(basename "$cwd")

# Get git branch from workspace.git_worktree or by running git
branch=$(echo "$input" | jq -r '.worktree.branch // empty')
if [ -z "$branch" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Context window used percentage
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Weekly (7-day) rate limit used percentage
week_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Current mode: vim mode if active, else permission mode from settings
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
perm_mode=$(jq -r '.permissions.defaultMode // empty' "$HOME/.claude/settings.json" 2>/dev/null)
if [ -n "$vim_mode" ]; then
  mode="$vim_mode"
elif [ -n "$perm_mode" ]; then
  mode="$perm_mode"
else
  mode=""
fi

# ANSI color codes (matching zsh theme colors)
blue='\033[34m'
yellow='\033[33m'
red='\033[31m'
magenta='\033[35m'
cyan='\033[36m'
green='\033[32m'
white='\033[37m'
reset='\033[0m'
bold='\033[1m'
dim='\033[2m'

# Build the prompt prefix: dir + arrows + branch
if [ -n "$branch" ]; then
  printf "${bold}${blue}%s ${yellow}>${red}>${magenta}>${cyan} %s${reset}" "$dir" "$branch"
else
  printf "${bold}${blue}%s ${yellow}>${red}>${magenta}>${reset}" "$dir"
fi

# Append context used %
if [ -n "$ctx_used" ]; then
  ctx_int=$(printf '%.0f' "$ctx_used")
  printf "${dim}${white}  ctx:%s%%${reset}" "$ctx_int"
fi

# Append weekly usage %
if [ -n "$week_used" ]; then
  week_int=$(printf '%.0f' "$week_used")
  printf "${dim}${white}  7d:%s%%${reset}" "$week_int"
fi

# Append mode
if [ -n "$mode" ]; then
  printf "${dim}${green}  [%s]${reset}" "$mode"
fi
