# dev environment
alias tmux="TERM=screen-256color-bce tmux"
alias ta="tmux attach"

zj() {
  if [ $# -eq 0 ]; then
    zellij
  else
    zellij attach $1 || cd $1 && zellij -s $1 && cd -
  fi
}

nv() {
  if [ $# -eq 0 ]; then
    nvim
  else
    if [ -d "$1" ]; then
      cd $1 && nvim && cd -
    else
      if [ -f "$1" ]; then
        nvim "$1"
      else
        echo "Invalid argument."
      fi
    fi
  fi
}
dev() {
  if [ $# -eq 0 ]; then
    echo "Please specify a project"
  else
    parts=("${(@s:/:)1}")
    default_account=${PROJ_ACCOUNT:-mcjcloud}
    account=${parts[1]:-$default_account}
    repo=$parts[2]
    if [[ -z $parts[2] ]]; then
      account=$default_account
      repo=$parts[1]
    fi

    final_path="${PROJ_DIR:-"~"}/$account/$repo"

    if [ -d $final_path ]; then
      nv $final_path
    else
      echo "$1 is not a directory"
    fi

  fi
}
expand_proj_dir() {
  for i in $@
  do
    echo "$PROJ_DIR/$i"
  done
}

# Git branch in prompt
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable (shell prompt)
zstyle ':vcs_info:git:*' formats ' %F{011}%r%f %F{010}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{006}[%n]%f${vcs_info_msg_0_} ${PWD/#$HOME/~}
$ '

# fzf
eval "$(fzf --zsh)"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  echo $command

  case "$command" in
    cd|nv)        fzf --preview 'eza --tree --level=2 --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    dev)          fzf --preview 'eza --tree --level=2 --color=always {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
_fzf_complete_dev() {
  shift
  _fzf_complete --multi --reverse -- "$@" < <(expand_proj_dir $(/bin/ls $PROJ_DIR))
}

# syntax highlight less
alias lesh='LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s" less -M '

# eza
alias ls="eza --color=always --long --git --icons=always --no-time"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"
