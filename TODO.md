iTerm2-Configuration:

/bin/sh -c "TMUX_DETACHED_CLIENT=\$(/usr/local/bin/tmux ls | grep -v '(attached)' | grep -Eow '\d+' | head -n 1); [ -z \$TMUX_DETACHED_CLIENT ] && /usr/local/bin/tmux || /usr/local/bin/tmux attach-session -t \$TMUX_DETACHED_CLIENT"

Works in shell (prefix with TMUX=) but not as command to start a new iTerm session. It still always creates a new session.

xcode for ruby? `sudo xcodebuild -license accept`


.bundle/config
.heroku/config.json
.config/heroku/config.json
# Heroku see info on autocompletion
.ruby-version
.config/git/ignore ?


SECRET
.boto
.gem/credentials
.gnupg
.keybase
.ngrok2/ngrok.yml
.ssh
.config/hub

## Notes

If running inside tmux, you might want to use reattach-to-user-namespace TODO: Maybe automate this?

TODO: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

* [ ] remove `export` again? Why did I need them anyway?
* [ ] check root Brewfile (now empty)
* [ ] allow specification of dependencies between packages (just `dotfiles install xy` in `install`?)
* [ ] check all packages for dependencies and use above mechanism (eg ripgrep, fzf, ...)
* [ ] system configuration
* [ ] find a way to configure eg sum.cumo specific stuff in local files/external repos (karabiner/hammerspoon/...)
* [ ] switch to viscosity? https://www.sparklabs.com/support/kb/article/controlling-viscosity-with-applescript-mac/
