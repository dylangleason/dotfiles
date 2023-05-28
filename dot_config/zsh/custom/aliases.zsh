if command -v lsd > /dev/null; then
    alias ls='lsd --group-directories-first'
else
    alias ls='ls -h --group-directories-first'
fi

alias ll='ls -l'
alias la='ls -a'
alias e='emacs -nw'
alias ec='emacsclient -a "" -t'
