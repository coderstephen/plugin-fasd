function fasd_cd -d 'Function to execute built-in cd'
  # if no $argv, identical with `fasd`
  if test (count $argv) -le 1
    fasd "$argv"
  else
    set -l ret (fasd -e 'printf %s' $argv)
    test -z "$ret";
      and return
    test -d "$ret";
      and builtin cd "$ret";
      or printf "%s\n" $ret
  end
end
