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

# Fancy stuff like colors, bold and underline markers for terminal
[ -f ~/.config/bash/fancy ] && . ~/.config/bash/fancy

# Git information
[ -f ~/.config/bash/git ] && . ~/.config/bash/git

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]
then
  debian_chroot=$(cat /etc/debian_chroot)
fi
# Set prompt
PS1="\n$color_bold$color_bred\${?##0}$color_clear" # New line and exit code
PS1="$PS1${debian_chroot:+($debian_chroot)}" # Chroot information
PS1="$PS1$color_bold$color_fyellow\u$color_clear@" # Username
PS1="$PS1$color_bold$color_fred\h$color_clear:" # Hostname
PS1="$PS1$color_bold$color_fblue\w$color_clear" # Working directory
PS1="$PS1$color_bold$color_fgreen\$(git_prompt)$color_clear\$ " # Git prompt
# If this is an xterm set the window title
case "$TERM" in
  xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
  *) ;;
esac

# Exports
[ -f ~/.config/bash/exports ] && . ~/.config/bash/exports

# Aliases
[ -f ~/.config/bash/aliases ] && . ~/.config/bash/aliases

# Default completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix
then
  . /etc/bash_completion
fi
# Personal completion
if [ -f ~/.config/bash/completion ] && ! shopt -oq posix
then
  . ~/.config/bash/completion
fi
