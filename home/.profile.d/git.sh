# * means unstaged, + means staged
export GIT_PS1_SHOWDIRTYSTATE=true
# $ means stash
export GIT_PS1_SHOWSTASHSTATE=true
# % means untracked files
export GIT_PS1_SHOWUNTRACKEDFILES=true

alias git-diff="git diff | mate"
alias git-ignored="say-and-execute git ls-files --others -i --exclude-standard"
alias git-ignored-all="say-and-execute git ls-files --others"

alias git-stash-tmp="git add . && git stash save 'tmp'"
alias git-unstash-tmp="git stash pop"

alias gs="say-and-execute git status"
alias gpull="say-and-execute git pull";              alias gpl="gpull"
alias gpr="say-and-execute git pull --rebase"
alias grebase="say-and-execute git rebase";          alias gr="grebase"
alias gpush="say-and-execute git push";              alias gps="gpush"
alias gsvn="say-and-execute git svn"
alias gsvnrebase="say-and-execute git svn rebase";   alias gsvnr="gsvnrebase"
alias gsvndcommit="say-and-execute git svn dcommit"; alias gsvnd="gsvndcommit"
alias gsl="say-and-execute git stash list"

function gss() {
  VERSION=$1
  if [ "$VERSION" == "" ]; then
    VERSION=0
  fi
  say-and-execute git stash show -v stash@{$VERSION}
}

function git-rebase-master() {
  BRANCH=`git branch | awk '/\*/ {print $2}'`
  git checkout master && git pull --rebase && git checkout $BRANCH && git rebase master
}

function git-merge-master() {
  BRANCH=`git branch | awk '/\*/ {print $2}'`
  git checkout master && git pull --rebase && git checkout $BRANCH && git merge master
}

function git-log-since() {
  git log $1..HEAD --oneline | sed '1!G;h;$!d'
}

function git-init-for-xcode() {
  git init
  echo "*.pbxproj -crlf -diff -merge" > .gitattributes
  echo "# xcode noise
build
*.pbxuser
*.mode1v3

# osx noise
profile" > .gitignore
  git add .
  git commit -m 'freshly created'
}

function git-share-on-coderei() {
  git-share coderei@git.coderei.de: $1
}

function git-share-on-github() {
  git-share git@github.com:thomasjachmann/ $1
}

function git-share() {
  REPO=$2
  if [ "$REPO" == "" ]; then
    DIR=`pwd`
    REPO=`basename $DIR`
  fi
  git remote add origin $1$REPO.git
  git config branch.master.remote origin
  git config branch.master.merge refs/heads/master
}
