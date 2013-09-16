function serveit() {
  local port=$1
  if [[ "$port" == "" ]]; then
    port=8000
  fi
  python -m SimpleHTTPServer $port
}
