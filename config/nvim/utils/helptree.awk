function parse_line(line) {
  ret = match(line, /["-]{3}\w+/)
  if (ret == 0) {
    gsub(/^["-]{3} ?/, "", line)
    print line
  } else {
    split(line, arr, " ")
    key = arr[1]
    gsub(key, "", line)
    gsub(/["-]{3}/, "", key)
    store[key] = store[key] "\n" line
  }
}

FS=/^["-]{3}/ NF>1 {
  parse_line($0)
}
END {
  for (i in store) {
    printf "# %s",  i
    print store[i]
    print "\n\n"
  }
}
