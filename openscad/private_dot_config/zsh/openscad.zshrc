function openscad-new() {
  [ -z "$1" ] && echo "no project specified" >&2 && return 1

  mktcd "$HOME/Projects/3d_printing/$1"

  file="$1.scad"
  # touch "$file"
  echo "\$fa = 1;\n\$fs = 0.1;\n" >> "$file"

  open -a OpenSCAD "$file"
  vi "$file"
}
