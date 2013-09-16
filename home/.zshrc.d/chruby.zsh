source `brew --prefix chruby`/share/chruby/chruby.sh
source `brew --prefix chruby`/share/chruby/auto.sh

function chruby-version() {
  # ruby --version | cut -d " " -f2
  local ruby_version=`chruby | grep '*' | sed 's/ \* //'`
  local specific_version=`readlink ~/.rubies/$ruby_version`
  if [[ $specific_version != "" ]]; then
    ruby_version="$ruby_version ($specific_version)"
  fi
  echo $ruby_version
}
