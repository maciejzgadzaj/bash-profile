# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 002

# Show unstaged (*) and staged (+) changes next to the branch name.
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto"

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

if [ -f ~/.git-completion.sh ]; then
    . ~/.git-completion.sh
fi


# User paths.

if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

if [ -d ~/drush ] ; then
    PATH=~/drush:"${PATH}"
fi

if [ -d ~/.composer/vendor/bin ]; then
    PATH=~/.composer/vendor/bin:"${PATH}"
fi

if [ -d ~/pear/share/pear ]; then
    PATH=~/pear/share/pear:"${PATH}"
fi


# System paths.

if [ -d /opt/local/bin ]; then
    PATH=/opt/local/bin:"${PATH}"
fi

if [ -d /opt/local/sbin ]; then
    PATH=/opt/local/sbin:"${PATH}"
fi

if [ -d /usr/local/pgsql/bin ]; then
    PATH=/usr/local/pgsql/bin/:"${PATH}"
fi

