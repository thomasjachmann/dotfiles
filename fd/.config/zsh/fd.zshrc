alias fd="noglob fd"

function fd-largest() {
  fd -u -t f "" ${2:-.} -X ls -lhS | head -n ${1:-10}
}

function fd-newest() {
  fd -u -t f "" ${2:-.} -X ls -lht | head -n ${1:-10}
}
