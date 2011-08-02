function add_host() {
  HOST=$1
  if [ "$HOST" == "" ]; then
    echo "please specify a host name"
    return
  fi
  ADDRESS=$2
  if [ "$ADDRESS" == "" ]; then
    ADDRESS=127.0.0.1
  fi
  sudo dscl localhost -create /Local/Default/Hosts/$HOST IPAddress $ADDRESS
  dscl localhost -read /Local/Default/Hosts/$HOST
}

function remove_host() {
  HOST=$1
  if [ "$HOST" == "" ]; then
    echo "please specify a host name"
    return
  fi
  sudo dscl localhost -delete /Local/Default/Hosts/$HOST
  dscl localhost -list /Local/Default/Hosts
}

function list_hosts() {
  dscl localhost -list /Local/Default/Hosts
}

function read_host() {
  HOST=$1
  if [ "$HOST" == "" ]; then
    echo "please specify a host name"
    return
  fi
  dscl localhost -read /Local/Default/Hosts/$HOST
}