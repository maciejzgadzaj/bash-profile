
# listing / displaying
alias l='ls -al --color=auto'
alias ll='ls -al --color=always | less -R'
alias tailf='tail -f'
alias zcatl='zcat $1 | less'

# prompt before overwrite / delete
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# directories
alias md='mkdir -p'
alias rd='rmdir'
# Create directory(ies) and go there
mdcd () { mkdir -p "$1" && cd "$1" ; }

# disk free / usage
alias df='df -h'
alias du='du -hs'

# history
alias h='history'
alias hg='history | grep -i $1 --color=auto'

# processes
alias ps='ps -ef'
alias psg='ps -ef | grep $1 --color=auto'

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
function ff() { find . -type f -iname '*'$*'*' -ls ; }
function sff() { sudo find . -type f -iname '*'$*'*' -ls ; }

# colorful, recursive grep with line numbers and excluding SVN
gr () { grep -risn "$1" . --color=always | grep -v '.svn\|.git\|\~' ; }
grl () { grep -risn "$1" . --color=always | grep -v '.svn\|.git' | less -R ; }

# grep for gzipped files
# 1st param: string to look for
# 2nd param: filename mask (
fzgrep () {
    if [ "$2" ]
    then
        filemask="$2"
    else
        filemask='*.gz'
    fi
    find . -name "$filemask" -exec sh -c 'zcat $0 | grep -in '$1' --color=always' {} \; -ls
}
alias zgr='fzgrep'

# svn
st () { svn st -u "$1" ; }
sd () { svn diff "$1" | colordiff ; }
sdr () { svn diff -rhead "$1" | colordiff ; }
sl () { svn log "$1" |more ; }
# Add all files not yet added to SVN
svnaddall () { svn st | grep "^?" | awk -F "      " '{print $2}' | xargs svn add ; }
# Delete all deleted files from SVN
svndelall () { svn st | grep "^\!" | awk -F "      " '{print $2}' | xargs svn delete ; }
# Update all repositories found inside current/specified directory
function svnupall () {
    if [ "$1" ]
    then
        path="$1"
    else
        path='.'
    fi
    if [[ -d $path ]]
    then
        if [[ -d $path/.svn ]]
        then
            echo "Updating $path"
            svn up $path
        else
            for d in $(find $path -maxdepth 1 -type d ! -wholename $path)
            do
                svnupall $d
            done
        fi
    fi
}
# Delete all .svn directories starting from current directory
svnclean () { find . -name '.svn' -exec rm -rf '{}' \; ; }

# apt-get
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agp='sudo apt-get remove --purge'
alias agu='sudo apt-get update'
alias agc='sudo apt-get autoclean && sudo apt-get autoremove'
alias ags='sudo vim /etc/apt/sources.list'

# do sudo, or sudo the last command if no argument given
s() {
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

# misc
alias ftop="watch -d -n 1 'df; ls -FlAS;'"
alias chmodf='chmod 644 $(find . -type f)'
alias chmodd='chmod 755 $(find . -type d)'

