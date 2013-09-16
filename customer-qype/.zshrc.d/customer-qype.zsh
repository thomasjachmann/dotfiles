# TODO add q function that does everything and has argument hints
# http://zsh.sourceforge.net
# function q() {
#   if [[ "$1" == ""]]; then
#     q-cd
#   fi
# }

alias q-cd="cd ~/Projects/qype/main/qype"
alias q-open="s ~/Projects/qype/main"
alias q-open-web="s ~/Projects/qype/main/main-qype.sublime-project"
alias q-open-admin="s ~/Projects/qype/main/main-qype-admin.sublime-project"
alias q-open-api="s ~/Projects/qype/main/main-qype-api.sublime-project"

function q-start() {
  say-and-execute sudo /usr/libexec/ApplicationFirewall/socketfilterfw -t nginx
  say-and-execute sudo nginx -c ~/Projects/qype/tech/infra/nginx.conf
  say-and-execute redis-server /usr/local/etc/redis.conf
  say-and-execute memcached -d
  say-and-execute mysql.server start
}
function q-end() {
  say-and-execute sudo nginx -s stop
  say-and-execute redis-cli shutdown
  say-and-execute killall memcached
  say-and-execute mysql.server stop
}

alias q-begin="q-start && q-cd && q-open"

function q-test() {
  say-and-execute ruby -Ilib:test "$(bundle show rake)/lib/rake/rake_test_loader.rb" "$@"
}

function q-unicorn() {
  say-and-execute export QYPE_SSL=true
  say-and-execute export QYPE_USE_MEMCACHED=1
  say-and-execute bundle exec unicorn_rails -c config/unicorns/debugger.rb -p $1
}

function q-web() {
  q-cd
  q-unicorn 8080
}

function q-admin() {
  q-cd
  cd ../qype-admin
  q-unicorn 8081
}

function q-api() {
  q-cd
  cd ../qype-api
  q-unicorn 8082
}

function q-mobile-start() {
  host=$1
  if [[ "$host" == "" ]]; then
    host="myqype"
  fi
  # say-and-execute sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.InternetSharing.plist
  # sleep 5
  say-and-execute sudo killall named
  # local en0_ip=`ifconfig en0 | grep 'inet ' | cut -d ' ' -f2`
  local en1_ip=`ifconfig en1 | grep 'inet ' | cut -d ' ' -f2`
  # echo local ip is $en1_ip
  say-and-execute sudo /usr/libexec/ApplicationFirewall/socketfilterfw -t dnsmasq
  say-and-execute sudo dnsmasq -h -i en1 -A /$host.com/$en1_ip -A /$host.co.uk/$en1_ip -A /$host.de/$en1_ip -A /$host.fr/$en1_ip -A /$host.es/$en1_ip -A /$host.it/$en1_ip -A /$host.pl/$en1_ip -A /$host.ie/$en1_ip -A /$host.at/$en1_ip -A /$host.ch/$en1_ip -A /$host.nl/$en1_ip -A /$host.pt/$en1_ip -A /$host.com.br/$en1_ip -A /$host.com.tr/$en1_ip -A /api.qype.com/$en1_ip
  echo "now point your phone's DNS to $en1_ip"
}
function q-mobile-end() {
  say-and-execute sudo killall dnsmasq
  # say-and-execute sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.InternetSharing.plist
}

# alias rtest="ruby -I'lib:test' $*"

# function q-test() {
#   CMD="ruby -I\"lib:test\" $1"
#   if [[ $# -ge 2 ]]; then
#     CMD="$CMD -n $2"
#   fi
#   say-and-execute $CMD
# }
