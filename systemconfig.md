# Spotlight

http://recomhub.com/blog/mac-os-x-el-capitan-how-to-turn-on-and-off-spotlight-search/

```bash
sudo mdutil -a -i off
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
```
