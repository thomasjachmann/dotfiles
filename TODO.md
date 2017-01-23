iTerm2-Configuration:

/bin/sh -c "TMUX_DETACHED_CLIENT=\$(/usr/local/bin/tmux ls | grep -v '(attached)' | grep -Eow '\d+' | head -n 1); [ -z \$TMUX_DETACHED_CLIENT ] && /usr/local/bin/tmux || /usr/local/bin/tmux attach-session -t \$TMUX_DETACHED_CLIENT"

Works in shell (prefix with TMUX=) but not as command to start a new iTerm session. It still always creates a new session.


.bundle/config
.heroku/config.json
.config/heroku/config.json
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
