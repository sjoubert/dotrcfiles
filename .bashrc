#!/bin/bash

# If not running interactively, don't do anything
# See bash documentation about $-
case $- in
  *i*) ;;
  *) return;;
esac

# Don't put duplicate lines in the history
HISTCONTROL=ignoredups
# Append to the history file, don't overwrite it
shopt -s histappend
# Set history length
HISTSIZE=1000
HISTFILESIZE=2000
# Set history file
HISTFILE=~/.config/bash/history

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# Colors
if [ -f ~/.config/bash/colors ];
then
  . ~/.config/bash/colors
fi

# Git informations
function parse_git_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function parse_git_status
{
    notclean=`git status --porcelain 2> /dev/null | grep -E "^.(??|M|A|D|R|C|U)" | wc -l`

    if [[ $notclean -gt 0 ]]; then echo -n "*"; fi
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1="\n${debian_chroot:+($debian_chroot)}$YELLOW\u$NC@$RED\h$NC:$BLUE\w$GREEN\$(parse_git_branch)\$(parse_git_status)$NC\$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the windom title
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# Exports
if [ -f ~/.config/bash/exports ];
then
  . ~/.config/bash/exports
fi

# Aliases
if [ -f ~/.config/bash/aliases ];
then
  . ~/.config/bash/aliases
fi

# Completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix;
then
  . /etc/bash_completion
fi
