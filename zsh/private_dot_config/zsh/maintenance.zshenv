function maintain() {
  file=$ZDOTDIR/.maintain.d/$1.zsh
  if [ -x "$file" ]; then
    echo "######################################################################"
    echo "# $file"
    echo "######################################################################"
    $file
  else
    for file in $ZDOTDIR/.maintain.d/*; do
      echo "######################################################################"
      echo "# $file"
      echo "######################################################################"
      $file
    done
  fi
}

function upgrade() {
  file=$ZDOTDIR/.upgrade.d/$1.zsh
  if [ -x "$file" ]; then
    echo "######################################################################"
    echo "# $file"
    echo "######################################################################"
    $file
  else
    for file in $ZDOTDIR/.upgrade.d/*; do
      echo "######################################################################"
      echo "# $file"
      echo "######################################################################"
      $file
    done
  fi
}
