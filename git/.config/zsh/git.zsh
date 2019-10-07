# * means unstaged, + means staged
# export GIT_PS1_SHOWDIRTYSTATE=true
# $ means stash
# export GIT_PS1_SHOWSTASHSTATE=true
# % means untracked files
# export GIT_PS1_SHOWUNTRACKEDFILES=true

alias git="LANG=C git"
alias gti="git"
alias gut="git"
alias got="git"
alias it="git"

alias tiga="tig --all"
alias tigs="tig status"
alias tigt='tig $(git rev-parse --abbrev-ref HEAD)..$(git tracking)'

function git-upgrade-submodules() {
  git submodule foreach "
    while true; do
      read -p \" Do you wish to upgrade? [Yn] \" -n 1 -s answer
      [[ \"\$answer\" == \"\" ]] && local answer=y
      echo \$answer
      case \$answer in
        Y|y)
          git pull origin master
          break;;
        N|n)
          break;;
      esac
    done
  "
}

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

# establish branch autocompletion for complex git aliases where this cannot be
# determined automatically
# see https://coderwall.com/p/d2w7oa/auto-completion-within-complex-git-alias
function _git_cod() { _git_branch }
function _git_codd() { _git_branch }
