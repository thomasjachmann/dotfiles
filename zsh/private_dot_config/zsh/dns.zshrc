function add_host() {
  local host=$1
  if [[ "$host" == "" ]]; then
    echo "please specify a host name"
    return
  fi
  local address=$2
  if [[ "$address" == "" ]]; then
    address=127.0.0.1
  fi
  sudo dscl localhost -create /Local/Default/Hosts/$host IPAddress $address
  dscl localhost -read /Local/Default/Hosts/$host
}

function remove_host() {
  local host=$1
  if [[ "$host" == "" ]]; then
    echo "please specify a host name"
    return
  fi
  sudo dscl localhost -delete /Local/Default/Hosts/$host
  dscl localhost -list /Local/Default/Hosts
}

function list_hosts() {
  dscl localhost -list /Local/Default/Hosts
}

function read_host() {
  local host=$1
  if [[ "$host" == "" ]]; then
    echo "please specify a host name"
    return
  fi
  dscl localhost -read /Local/Default/Hosts/$host
}