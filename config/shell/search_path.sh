aqua () {
  if [[ "$1" == "" ]]; then
    psql aquameta
  elif [[ "$2" == "" ]]; then
    psql "dbname=aquameta options=--search_path=$1"
  else
    psql "dbname=aquameta options=--search_path=$1" ${@:2}
  fi
}
