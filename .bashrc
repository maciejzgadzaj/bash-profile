

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# Shell behavior variables (see 'man bash' for details)

# correct typing errors
shopt -s cdspell

# allow use of exported variables in cd
shopt -s cdable_vars

# checks that a command found in the hash table exists
# before trying to execute it.  If a hashed command
# no longer exists, a  normal path search is performed
shopt -s checkhash

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# attempts to save all lines of a multiple-line command
# in the same history entry.  This allows easy re-editing
# of multi-line commands
shopt -s cmdhist

# enabled extended pattern matching features
shopt -s extglob

# append to the history file, don't overwrite it
# opportunity to re-edit a failed history substitution
# history substitution not immediately passed to the shell parser
shopt -s histappend histreedit histverify

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
 HISTSIZE=10000

# if readline is being used, bash will not attempt to search the PATH
# for possible completions when completion is attempted on an empty line
shopt -s no_empty_cmd_completion

# the source (.) builtin uses the value of PATH to find
# the directory containing the file supplied as an argument
shopt -s sourcepath

# ignore case, long prompt, exit if it fits on one screen, allow colors for ls and grep colors
export LESS="-iMFXR"

# allow ctrl-S (forward search) for history navigation (with ctrl-R)
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
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
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    for i in `find ~ -maxdepth 1 -type f -name .bashrc_ps1\*`; do
        . $i
    done
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# MySQL prompt
if [ -x /usr/bin/rlwrap ]; then
    alias mysql='/usr/bin/rlwrap -a -pGREEN /usr/bin/mysql'
fi
export MYSQL_PS1="\u@\h:/\d$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Default editor
export EDITOR=vim

export LESSCHARSET='latin1'

# Alias definitions.
for i in `find ~ -maxdepth 1 -type f -name .bash_aliases\*`; do
    . $i
done

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -d ~/pear/share/pear ]; then
    export PATH="~/pear/share/pear:$PATH"
fi

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline

# Include Drush bash customizations.
if [ -f "/home/mzgadzaj/.drush/drush.bashrc" ] ; then
  source /home/mzgadzaj/.drush/drush.bashrc
fi

# Include Drush completion.
if [ -f "/home/mzgadzaj/.drush/drush.complete.sh" ] ; then
  source /home/mzgadzaj/.drush/drush.complete.sh
fi

# Include Drush prompt customizations.
#if [ -f "/home/mzgadzaj/.drush/drush.prompt.sh" ] ; then
#  source /home/mzgadzaj/.drush/drush.prompt.sh
#fi

# Include Drupal Console completion.
source "$HOME/.console/console.rc" 2>/dev/null

