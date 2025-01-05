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
alias ls='eza -l'
alias grep='grep --color=auto'
alias la='eza -a'
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

alias vim='nvim'

alias deleteDS_Store="find . -name .DS_Store -delete"

export EDITOR='nvim'

# brew stuff
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH:~/.scripts:~/.spicetify
export PATH=$PATH:/Users/tcmb139/.dotfiles/scripts/.scripts/mbcp
alias ibrew="arch -x86_64 /usr/local/bin/brew"

export PATH=$HOME/.emacs.d/bin:$PATH

# for cp
ulimit -s unlimited

#syntax highlighting
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

alias luamake=/Users/tcmb139/.config/nvim/lsps/lua-language-server/3rd/luamake/luamake

# fuck
eval $(thefuck --alias)

# fzf
# tokyonight dark
export FZF_DEFAULT_OPTS='--color=bg+:#292e42,bg:#16161e,border:#1f2335,hl:#ff9e64,fg:#a9b1d6,header:#292e42,pointer:#bb9af7,fg+:#a9b1d6,preview-bg:#24283b,prompt:#7dcfff,hl+:#7aa2f7,info:#e0af68'
# tokyonight day
# export FZF_DEFAULT_OPTS='--color=bg+:#c4c8da,bg:#e9e9ec,border:#e9e9ec,hl:#b15c00,fg:#6172b0,header:#c4c8da,pointer:#9854f1,fg+:#6172b0,preview-bg:#e1e2e7,prompt:#007197,hl+:#2e7de9,info:#8c6c3e'

export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_391`

export PATH=$PATH:/opt/anaconda3/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

