# TODO ignore Lightroom previews in Previews.lrdata

function backup-directory() {
  rsync --archive --hard-links --extended-attributes --verbose --human-readable --itemize-changes $1 $2
}

function backup-photos() {
  backup-directory /Volumes/RedPiglet/Photos/ /Volumes/RedBackup/Photos
  backup-directory /Volumes/RedPiglet/Ultraschall/ /Volumes/RedBackup/Ultraschall
}

function backup-dump() {
  backup-directory /Volumes/RedPiglet/Dump/ /Volumes/RedBackup/Dump
}

function backup() {
  backup-photos
  backup-dump
}

function backup-import() {
  backup-directory /Users/thomas/Pictures/Import/ /Volumes/Macintosh\ HD/Backup/Import
}

# see
# http://www.thegeekstuff.com/2010/09/rsync-command-examples/
# http://www.mikerubel.org/computers/rsync_snapshots/
# http://blog.interlinked.org/tutorials/rsync_time_machine.html
# http://danielmcgraw.com/2010/02/25/Incremental-Rotating-Backups-With-Rsync/
# http://www.cyberciti.biz/faq/linux-unix-apple-osx-bsd-rsync-copy-hard-links/
