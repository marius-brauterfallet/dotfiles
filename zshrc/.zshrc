# Source all .zsh files in ~/.zshrc.d
for file in ~/.zshrc.d/*.zsh; do
  source "$file"
done

HISTFILE=~/.zshrc.d/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS  # don't save duplicate consecutive commands
setopt HIST_IGNORE_SPACE # don't save commands prefixed with a space (useful for sensitive commands)
setopt HIST_VERIFY       # show the expanded history command before running it
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
bindkey -v
KEYTIMEOUT=5

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
  [[ -n $branch ]] && echo " \uf418 $branch"
}

PRE_PROMPT_MARKER=''$'\u276f'
PROMPT='
%F{green}%n@%m%f %F{blue}%~%f$(parse_git_branch)
${PRE_PROMPT_MARKER} '

RPROMPT='%F{yellow}%D{%d/%m/%Y} %T%f'

PROMPT_LINES=3

preexec() {
  printf '\033[%dA\033[J' $((PROMPT_LINES))
  printf "${PRE_PROMPT_MARKER} %s\n" "$1"
}

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

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

zle-line-init() {
  echo -ne '\e[5 q'
}
zle -N zle-line-init

setopt globdots

export EDITOR=nvim

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
export PATH="$HOME/.local/bin:$PATH"
