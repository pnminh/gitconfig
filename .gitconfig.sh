# config for git-prompt
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[00;33m\]"
YELLOW_BOLD="\[\033[01;33m\]"
BLUE="\[\033[00;34m\]"
BLUE_BOLD="\[\033[01;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[00;36m\]"
CYAN_BOLD="\[\033[01;36m\]"
GREEN="\[\033[00;32m\]"
GREEN_BOLD="\[\033[01;32m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[1;31m\]"
VIOLET='\[\033[01;35m\]'
WHITE='\[\033[00;37m\]'
WHITE_BOLD='\[\033[01;37m\]'
PURPLE='\[\033[00;35m\]'
PURPLE_BOLD='\[\033[01;35m\]'
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
function color_my_prompt {
  local __user_and_host="$WHITE\u" # \h =>to add host
  local __cur_location="$BLUE_BOLD\W"   #capital 'W': current directory, small 'w':full file path
  local __git_branch_color="$GREEN_BOLD"
  local __prompt_tail="$WHITE_BOLD$"
  local __user_input_color="$WHITE"
  #local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  #local __git_branch='$(__git_ps1 " (%s)")';
  local __git_branch='$(__git_ps1)';  

  # colour branch name depending on state
    if [[ "$(__git_ps1)" =~ "*" ]]; then           # if repository is dirty
       __git_branch_color="$RED_BOLD"
    elif [[ "$(__git_ps1)" =~ "$" ]]; then         # if there is something stashed
       __git_branch_color="$YELLOW_BOLD"
    elif [[ "$(__git_ps1)" =~ "%" ]]; then         # if there are only untracked files
       __git_branch_color="$YELLOW"
    elif [[ "$(__git_ps1)" =~ "+" ]]; then         # if there are staged files
       __git_branch_color="$CYAN_BOLD"

    elif [[ "$(__git_ps1)" =~ ">" ]]; then         # if local is ahead of remote
       __git_branch_color="$BLUE_BOLD"
    fi

  # build prompt string
  PS1="[$__user_and_host $__cur_location$__git_branch_color$__git_branch]$__prompt_tail$__user_input_color "
}
# call PROMPT_COMMAND which is executed before PS1
export PROMPT_COMMAND=color_my_prompt

# Uncomment below to use basic git-prompt (without colours)
#export PROMPT_COMMAND='__git_ps1 "\u:\W" "$"'

if [ -f $HOME/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . $HOME/.git-prompt.sh
fi

# Execute git completion
if ! shopt -oq posix; then
  if [ -f $HOME/.git-completion.bash ]; then
  . $HOME/.git-completion.bash
  fi
fi
