# Path to your oh-my-zsh configuration. 
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster-mod"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux extract themes zsh-syntax-highlighting)
# zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export PATH=$PATH:$HOME/bin
export EDITOR=vim
export PAGER=vimpager
#export LC_ALL=en_US.UTF-8
bindkey -v

# Aliases
alias less=$PAGER
alias zless=$PAGER 

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    vi-beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     vi-end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    vi-up-line-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  vi-down-line-or-history

bindkey "^P" vi-backward-blank-word 
bindkey "^W" vi-forward-blank-word 

. solarized-console.sh

[ ! "$UID" = "0" ] && fortune | cowsay -f eyes
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh # command-not-found hook https://aur.archlinux.org/packages.php?ID=52305

# dir colors
eval `dircolors ~/.dir_colors`

# Prompt
local return_code="%(?..%{$fg[red]%}%{$fg[white]$bg[red]%}%?)"
vim_ins_mode="%{$fg[green]%}%{$fg[black]$bg[green]%} INSERT %{$reset_color%}"
vim_cmd_mode="%{$fg[white]%}%{$fg[black]$bg[white]%} NORMAL %{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# PROMPT='' agnoster theme
RPROMPT='${return_code}${vim_mode}'

#. /usr/share/zsh/site-contrib/powerline.zsh

# title
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
[[ -t 1 ]] || return
case $TERM in
       *xterm*|*rxvt*|(dt|k|E|a)term)
    preexec () {
    print -Pn "\e]2;%n@%m  $1  %l\a"
    }
    ;;
    screen*)
        preexec () {
        print -Pn "\e\"%n@%m  $1  %l\e\134"             
    }
  ;; 
esac
function precmd() {
	print -Pn "\e]2;%n@%m  %~  %l\a"
}
# Misc
w3mimg () { w3m -o imgdisplay=/usr/lib/w3m/w3mimgdisplay $1 }
