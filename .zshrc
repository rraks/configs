###################################
# rraks' zsh config
#
###################################


##################
# Common
##################
export TERMINAL='kitty'
export EDITOR='nvim' 
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export DISABLE_AUTO_TITLE="true"
# Prevent globbing errors
unsetopt no_match

##################
# History
##################
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.



##################
# autocomplete
##################
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


##################
# vi mode
##################
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd v edit-command-line
bindkey -M vicmd "^V" edit-command-line

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


##################
# Syntax highlight
##################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /home/rraks/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh




##################
# FZF
##################
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND='rg --files'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


##################
# nnn
##################
source ~/.config/nnn/plugins/quitcd.zsh


##################
# Python
##################
export WORKON_HOME=~/venvs/
source /usr/bin/virtualenvwrapper.sh


##################
# JAVA
##################
export JAVA_HOME=/usr/lib/jvm/default



##################
# Rust
##################
export PATH="$HOME/.cargo/bin:$PATH"



##################
# Go
##################
export PATH="$PATH:$HOME/go/bin"


##################
# Terminal name
##################
# chpwd() {
#   [[ -t 1 ]] || return
#   case $TERM in
#     sun-cmd) print -Pn "\e]l%~\e\\"
#       ;;
#     *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
#       ;;
#   esac
# }

function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}


##################
# Aliases
##################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Neovim
alias vim='nvim'

# tmux
alias tns='tmux new-session -s'

# XDG 
alias xo='xdg-open'

# Chrome
alias chrome='google-chrome'

# LazyGit
alias lg='lazygit'

alias l='ls'

# todo.sh
alias t='todo.sh'



local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)



##################
# npm
##################
export PATH=$HOME/.npm-global/bin:$PATH

##################
# xhost
# For docker gui environment
##################
# xhost +local:root > /dev/null 2>&1


##################
# lua
##################
alias luamake=/home/rraks/lua-language-server/3rd/luamake/luamake
export PATH=$HOME/lua-language-server/bin:$PATH


##################
# starship
##################
eval "$(starship init zsh)"



##################
# Foot Term
##################
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd



##################
# Duck
##################
export PATH='/home/rraks/.duckdb/cli/latest':$PATH

# opencode
export PATH=/home/rraks/.opencode/bin:$PATH
