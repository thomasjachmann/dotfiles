export EDITOR="subl --new-window --wait"
export BUNDLER_EDITOR="subl --new-window"

alias slime="say-and-execute subl --new-window"

function s() {
  if [[ $# == 1 && -d $1 ]]; then
    local project_files=`find $1 -maxdepth 1 -name "*.sublime-project" | head -n 1`
    if [[ $#project_files > 0 ]]; then
      slime --project "$project_files"
    else
      slime "$@"
    fi
  else
    slime "$@"
  fi
}
