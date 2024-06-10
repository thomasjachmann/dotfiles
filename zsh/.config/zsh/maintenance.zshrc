function _maintain() {
  compadd $(fd -t l -d 1 "" $ZDOTDIR/.maintain.d/ -X printf '%s ' {/.} 2>/dev/null)
}
compdef _maintain maintain

function _upgrade() {
  compadd $(fd -t l -d 1 "" $ZDOTDIR/.upgrade.d/ -X printf '%s ' {/.} 2>/dev/null)
}
compdef _upgrade upgrade
