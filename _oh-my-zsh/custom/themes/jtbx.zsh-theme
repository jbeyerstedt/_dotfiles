# vim:ft=zsh ts=2 sw=2 sts=2
#
# oh-my-zsh theme of Jannik Beyerstedt, based on agnoster, ys and af-magic
# Features: git status, username/host (if not default), root indicator, python virtual environment
#           indicator, display exit code on error
#
# Usage/ Customisation:
# - currently none
#
# Output: # $status, $venv, user@host $dir $git_status, exit_code
#         $



### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Status:
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙%{$reset_color%}"

  if [[ -n "$symbols" ]] && echo -n "$symbols"
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    if [[ "$USER" != "$DEFAULT_USER" ]]; then
      echo -n "%{$terminfo[bold]%F{green}%}%n@%m%{$reset_color%}:"
    else
      echo -n "%{$terminfo[bold]%F{green}%}@%m%{$reset_color%}:"
    fi
  else
    if [[ "$USER" != "$DEFAULT_USER" ]]; then
      echo -n "%{$terminfo[bold]%F{green}%}%n%{$reset_color%}:"
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n "%{%F{blue}%}%~%{$reset_color%} "
}

# Virtualenv: current working virtualenv (TODO: test this)
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    echo -n "(`basename $virtualenv_path`) "
  fi
}

# Exit Code: display decimal exit code on error
prompt_exitcode() {
#   echo -n "%(?,,C:%{%F{red}%}%?%{$reset_color%})"
  [[ $RETVAL -ne 0 ]] && echo -n "C:%{%F{red}%}%?%{$reset_color%}"
}


# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      echo -n "%{$terminfo[bold]%F{cyan}%}(%{%F{yellow}%}"
    else
      echo -n "%{$terminfo[bold]%F{cyan}%}(%{%F{green}%}"
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//}${vcs_info_msg_0_%% }${mode}%{%F{cyan}%})%{$reset_color%} "
  fi
}


## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
#   prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
#   prompt_hg
  prompt_exitcode
}

PROMPT='
%{%f%b%k%}$(build_prompt)
%{$terminfo[bold]%F{blue}%}$ %{$reset_color%}%{%f%}'
