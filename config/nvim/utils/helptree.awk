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
  num = asorti(store, sorted_indices)
  for (i=1; i<=num; i++) {
    printf "# %s", sorted_indices[i]
    print store[sorted_indices[i]]
    print "\n\n"
  }
}
