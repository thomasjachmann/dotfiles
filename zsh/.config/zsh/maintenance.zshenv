function maintain() {
  for file in $ZDOTDIR/.maintain.d/*; do
    $file
  done
}

function upgrade() {
  for file in $ZDOTDIR/.upgrade.d/*; do
    $file
  done
}
