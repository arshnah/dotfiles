PROMPT="%~ "

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep

zstyle :compinstall filename "~/.zshrc"
autoload -Uz compinit && compinit
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

alias ls="ls -a --color=auto"
alias grep="grep --color=auto"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word

eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
