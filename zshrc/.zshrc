# Source all .zsh files in ~/.zshrc.d
for file in ~/.zshrc.d/*.zsh; do
  source "$file"
done 

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt HIST_IGNORE_ALL_DUPS
setopt CORRECT

autoload -Uz compinit
compinit

setopt promptsubst
autoload -Uz colors && colors

parse_git_branch() {
  local branch
  # branch=$((git branch 2>/dev/null) | grep '*' | sed 's/* //')
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n $branch ]] && echo " $branch"
}

PROMPT='%F{green}%n@%m%f %F{blue}%~%f$(parse_git_branch) %# '
