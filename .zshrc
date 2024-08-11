# MY VERSION OF A BASIC .zshrc

# to revert the options for the current shell to the default settings 
# -l option lists, not applies, settings. So can be used toh check defaults 
# emulate -LR zsh

# shell options
setopt AUTO_CD
setopt NO_CASE_GLOB

# history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=20000
HISTSIZE=10000
alias history="history 1"	# weirdly zsh's history cmd is fc  -l
setopt SHARE_HISTORY	# share history across multiple zsh sessions
setopt APPEND_HISTORY	# append to history
setopt HIST_REDUCE_BLANKS	# removes blank lines from history
setopt EXTENDED_HISTORY	# more data like timestamp in unix epoch time and elapsed time of the command
setopt INC_APPEND_HISTORY	# adds commands as they are typed, not at shell exit

# zsh correction
setopt CORRECT
setopt CORRECT_ALL

# aliases
alias ls='ls -G' # 'ls' is not a bash concept. MacOS's ls uses BSD's version 
alias ll='ls -l'
alias la='ls -a'
alias cp='cp -i' # interactive copy to alert overwriting/clobbering/etc.

# tab completions (apparently zsh offers amazing tab completion, but default is basic)
autoload -Uz compinit && compinit 

# git branch info to set in prompt
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('$branch')'
  fi
}

# original PS1
# %n@%m %1~ %#
# PS1 
PS1='%F{green}%B%n%b%f %F{cyan}%~%f %0(?..%F{red}<%?>%f)%F{yellow}$(git_branch_name)%f%# '
RPROMPT="%F{green}[%D{%b %d '%y | %T}]%f"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
