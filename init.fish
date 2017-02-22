set -q FASD_BIN
  or set -g FASD_BIN $path/fasd/fasd


# Hook into fish preexec event
function __fasd_run --on-event fish_preexec
  fasd --proc (fasd --sanitize "$argv" | tr -s ' ' \n) > /dev/null 2>&1
end

#expand-word -p '^(d|f)?,.*$' -e 'fasd.complete_word'
