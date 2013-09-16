# for tar: exclude ._ files (Mac OS X extended attributes)
COPYFILE_DISABLE=true

# for local executables
PATH=~/bin:$PATH

# for aliases/functions - print out command before executing it
function say-and-execute() {
  echo "=> $*"
  $*
}

function find-broken-links() {
  for i in `find . -type l`; do
    [ -e $i ] || echo symbolic link $i is broken
  done
}

# export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
# export EDITOR='mvim -f -c "au VimLeave * maca hide:"'


# temporary stuff

function log-mail() {
  inbox=`osascript -e 'tell application "Mail" to count of messages of inbox'`
  inbox_unread=`osascript -e 'tell application "Mail" to unread count of inbox'`
  sent=`osascript -e 'tell application "Mail" to count of messages of sent mailbox'`
  echo "`date +"%Y-%m-%d %H:%M"`, $inbox, $inbox_unread, $sent" >> ~/Desktop/mail-cleanup.log
  cat ~/Desktop/mail-cleanup.log
}
