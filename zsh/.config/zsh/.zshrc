# colors
autoload -U colors && colors
# PS1="%B%{$fg[magenta]%}➜ %{$fg[yellow]%}[%{$fg[blue]%}%c%{$fg[yellow]%}] %{$fg[magenta]%}✗%{$reset_color%}%b "
# PS1="%B%{$fg[magenta]%}➜  %{$fg[blue]%}%c%{$fg[magenta]%} ✗%{$reset_color%}%b "
# PS1=" %B%{$fg[blue]%}%c %{$fg[yellow]%}>%{$fg[red]%}>%{$fg[magenta]%}>%{$reset_color%}%b "
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %b'
setopt PROMPT_SUBST
PROMPT=' %B%{$fg[blue]%}%c %{$fg[yellow]%}>%{$fg[red]%}>%{$fg[magenta]%}>%{$fg[cyan]%}${vcs_info_msg_0_}%b '
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

bindkey -v
export KEYTIMEOUT=1

bindkey '^H' backward-kill-word
bindkey '^l' autosuggest-accept

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#confirm before doing something bad
alias cp='cp -i'                          # confirm before overwriting something
alias rm='rm -i'
alias mv='mv -i'

alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more='less'
alias q='exit'
alias c='clear'
alias h='history'
alias cs='clear;ls'
alias ls='exa -l'
alias grep='grep --color=auto'
alias la='exa -a'
alias l='la -l'
alias home='cd ~'
alias root='cd /'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

# youtube-dl
alias ytdl-aac="youtube-dl --extract-audio --audio-format aac "
alias ytdl-best="youtube-dl --extract-audio --audio-format best "
alias ytdl-flac="youtube-dl --extract-audio --audio-format flac "
alias ytdl-m4a="youtube-dl --extract-audio --audio-format m4a "
alias ytdl-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias ytdl-opus="youtube-dl --extract-audio --audio-format opus "
alias ytdl-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias ytdl-wav="youtube-dl --extract-audio --audio-format wav "
alias ytdl-best="youtube-dl -f bestvideo+bestaudio "

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

alias vpnup="sudo wg-quick up wg1"
alias vpndown="sudo wg-quick down wg1"
alias vpnrestart="vpndown && vpnup"
alias vpnstat="nmcli connection"

alias vim='nvim'

export EDITOR='nvim'
export PATH=$PATH:~/.scripts
export PATH=$HOME/.emacs.d/bin:$PATH

# music
alias listall="ls ~/Music/playlists/idk"
alias playlists="ls ~/Music/playlists"
play() { clear; mpv --no-video --loop --volume=50 "`find ~/Music/playlists/ | grep \"$@\"`"}
playlist() { clear; mpv --no-video --shuffle --loop-playlist=inf --volume=50 ~/Music/playlists/"$@" }
alias playall="mpv --no-video --shuffle --volume=50 ~/Music/playlists/*"

# for cp
ulimit -s unlimited
alias cdcp="cd ~/My\ Drive/programming/Competitive\ Programming/"

# google drive
alias drive="cd ~/My\ Drive/"

#syntax highlighting
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

alias luamake=/Users/tcmb139/.config/nvim/lsps/lua-language-server/3rd/luamake/luamake


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/Users/tcmb139/.ghcup/env" ] && source "/Users/tcmb139/.ghcup/env" # ghcup-env
