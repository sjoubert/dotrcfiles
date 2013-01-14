# colored commands
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# ls
alias ll='ls -lh'
alias la='ls -lhA'

# aptitude
alias sa='sudo aptitude'
alias aps='aptitude search'
alias sai='sudo aptitude install'
alias sau='sudo aptitude update'
alias sasg='sudo aptitude safe-upgrade'
alias safg='sudo aptitude full-upgrade'
alias sar='sudo aptitude remove'

# dev
alias makej='make -j$(($CPU_COUNT - 1))'
alias gdb='gdb -q'

