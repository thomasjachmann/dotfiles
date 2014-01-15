function backup-directory() {
  rsync --archive --hard-links --extended-attributes --verbose --human-readable --itemize-changes $*
}

function backup-photos() {
  backup-directory --exclude 'Backups' --exclude 'Photos Previews.lrdata' /Volumes/RedPiglet/Photos/ /Volumes/RedBackup/Photos
  backup-directory /Volumes/RedPiglet/Ultraschall/ /Volumes/RedBackup/Ultraschall
}

function backup-dump() {
  backup-directory /Volumes/RedPiglet/Dump/ /Volumes/RedBackup/Dump
}

function backup() {
  backup-photos
  backup-dump
}

# see
# http://www.thegeekstuff.com/2010/09/rsync-command-examples/
# http://www.mikerubel.org/computers/rsync_snapshots/
# http://blog.interlinked.org/tutorials/rsync_time_machine.html
# http://danielmcgraw.com/2010/02/25/Incremental-Rotating-Backups-With-Rsync/
# http://www.cyberciti.biz/faq/linux-unix-apple-osx-bsd-rsync-copy-hard-links/


# temporary stuff

function log-mail() {
  inbox=`osascript -e 'tell application "Mail" to count of messages of inbox'`
  inbox_unread=`osascript -e 'tell application "Mail" to unread count of inbox'`
  sent=`osascript -e 'tell application "Mail" to count of messages of sent mailbox'`
  echo "`date +"%Y-%m-%d %H:%M"`, $inbox, $inbox_unread, $sent, $*" >> ~/Desktop/mail-cleanup.log
  cat ~/Desktop/mail-cleanup.log
}
