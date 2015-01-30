
# listing / displaying
alias l='ls -alG'
alias ll='ls -alG | less -R'
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

# history
alias h='history'
alias hg='history | grep -i $1 --color=auto'

# processes
alias ps='ps -ef'
alias psg='ps -ef | grep $1 --color=auto'

# misc
if [[ -f /usr/bin/colordiff ]]; then
    diff () { /usr/bin/diff -rw "$@" | colordiff ; }
else
    diff () { /usr/bin/diff -rw "$@" ; }
fi

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
fgr () { find . -type f -not -regex '\(.svn\|.git\)' -and -regex '.*\.\(php\|inc\|module\|install\|class\|pl\|sh\|pm\|conf\|ini\|js\)' 2>/dev/null -exec grep -risnHE "$1" --color=always {} \;; }
zgr () { find . -name "*.gz" 2>/dev/null -exec zgrep -nHE "$1" --color=always {} \;; }

find-empty-dirs () {
  for folder in $(find . -type d); do
    if [ "`ls $folder | wc -l`" -eq 0 ]; then
      echo $folder
    fi
  done
}

# svn
st () { svn st -u "$@" ; }
sd () { svn diff "$@" | colordiff ; }
sdr () { svn diff -rhead "$@" | colordiff ; }
sl () { svn log "$@" |less ; }
sb () { svn blame "$@" |less ; }

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


gt () { git status "$@" ; }
gs () { git status -uno "$@" ; }
gl () { git lg "$@" ; }
gb () { git blame "$@" ; }
ga () { git add "$@" ; }
gap () { git add -p "$@" ; }
gc () { git commit "$@" ; }
gr () { git fetch origin && git reset --hard origin/$@ ; }
if [[ -f /usr/bin/colordiff ]]; then
    gd () { git diff -w "$@" | colordiff ; }
    gdc () { git diff -w --cached | colordiff ; }
    gdr () { git diff -w HEAD "$@" | colordiff ; }
else
    gd () { git diff -w "$@" ; }
    gdc () { git diff -w --cached ; }
    gdr () { git diff -w HEAD "$@" ; }
fi

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
