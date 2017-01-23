function serveit() {
  local port=$1
  if [[ "$port" == "" ]]; then
    port=8000
  fi
  # ruby -run -e httpd . -p $port
  python -m SimpleHTTPServer $port
}
