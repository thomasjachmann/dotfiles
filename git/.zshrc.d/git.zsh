# * means unstaged, + means staged
# export GIT_PS1_SHOWDIRTYSTATE=true
# $ means stash
# export GIT_PS1_SHOWSTASHSTATE=true
# % means untracked files
# export GIT_PS1_SHOWUNTRACKEDFILES=true

alias gti="git"
alias gut="git"
alias it="git"

alias tiga="tig --all"
alias tigs="tig status"

function gss() {
  local version=$1
  if [[ "$version" == "" ]]; then
    version=0
  fi
  say-and-execute git stash show -v stash@{$version}
}

function git-rebase-master() {
  local branch=$(current_branch)
  git checkout master && git pull --rebase && git checkout $branch && git rebase master
}

function git-merge-master() {
  local branch=$(current_branch)
  git checkout master && git pull --rebase && git checkout $branch && git merge master
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
  local repo=$2
  if [[ "$repo" == "" ]]; then
    local dir=`pwd`
    repo=`basename $dir`
  fi
  git remote add origin $1$repo.git
  git config branch.master.remote origin
  git config branch.master.merge refs/heads/master
}
