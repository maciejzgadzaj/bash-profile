
# listing / displaying
if [[ $(uname) == 'Linux' ]]; then
    alias l='ls -al --color=always'
    alias ll='ls -al --color=always | less -R'
elif [[ $(uname) == 'Darwin' ]]; then
    alias l='ls -alG'
    alias ll='ls -alG | less -R'
fi
alias tailf='tail -f'
alias zcatl='zcat $1 | less'

# prompt before overwrite / delete
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# directories
alias mkdir='mkdir -pv'
alias md='mkdir'
alias rd='rmdir'
# Create directory(ies) and go there
mdcd () { mkdir -p "$1" && cd "$1" ; }

# history
alias h='history'
alias hg='history | grep -i $1 --color=auto'

# go up in directory structure $1 levels
.. () {
    if [ $1 ]
    then
        up=$1
    else
        up=1
    fi
    for ((a=1; a<=up; a++))
    do
        cd ..
    done ;
}

# file finder
ff () { find . -type f -iname '*'$*'*' -ls ; }
sff () { sudo find . -type f -iname '*'$*'*' -ls ; }

# colorful, recursive grep with line numbers and excluding SVN
grp () { grep -risn "$1" . --color=always | grep -v '.svn\|.git\|\~' ; }
grl () { grep -risn "$1" . --color=always | grep -v '.svn\|.git' | less -R ; }
fgr () { find . -follow -type f -not -regex '\(.svn\|.git\)' -and -regex '.*\.\(php\|inc\|module\|install\|class\|pl\|sh\|pm\|conf\|ini\|js\)' 2>/dev/null -exec grep -risnHE "$1" --color=always {} \;; }
zgr () { find . -name "*.gz" 2>/dev/null -exec zgrep -nHE "$1" --color=always {} \;; }

gt () { git status "$@" ; }
gti () { git status --ignored "$@" ; }
gs () { git status -sb "$@" ; }
gsi () { git status -sb --ignored "$@" ; }
gl () { git l "$@" ; }
gll () { git ll "$@" ; }
glll () { git lll "$@" ; }
gb () { git blame "$@" ; }
ga () { git add "$@" ; }
gap () { git add -p "$@" ; }
gc () { git commit "$@" ; }
alias gca="git commit --amend"
gcm () { git commit -m "$@" ; }
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
gri () { git rebase -i HEAD~$@ ; }
gstat () { git shortlog -sne --no-merges ; }
gstatm () { git shortlog -sne ; }
if [[ -f /usr/bin/colordiff ]]; then
    gd () { git diff -w "$@" | colordiff ; }
    gdw () { git diff --color-words -w "$@" ; }
    gdc () { git diff -w --cached | colordiff ; }
    gdr () { git diff -w HEAD "$@" | colordiff ; }
else
    gd () { git diff -w "$@" ; }
    gdc () { git diff -w --cached ; }
    gdr () { git diff -w HEAD "$@" ; }
fi

# do sudo, or sudo the last command if no argument given
s() {
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

# misc
alias diff='colordiff -rw'
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
alias c='clear'

alias ftop="watch -d -n 1 'df; ls -FlAS;'"
alias chmodf='chmod 644 $(find . -type f)'
alias chmodd='chmod 755 $(find . -type d)'


if [ -d ~/.composer/vendor/drupal/coder/coder_sniffer/Drupal ]; then
    alias sniff='phpcs --standard=~/.composer/vendor/drupal/coder/coder_sniffer/Drupal/'
fi

