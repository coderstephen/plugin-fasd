function __fasd_print_completions
  set cmd (commandline -po)
  fasd $argv $cmd -l
end
