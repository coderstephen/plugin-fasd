function fasd.complete_word -d "Binding that provides word expansion"
  # Get the current token to complete
  set -l token (commandline -t)

  # Match the token against valid fasd word completions.
  switch "$token"
    # Match any directory or file.
    case ',?*'
      set -l queries (echo -n "$token" | cut -b 2- | tr ',' '\n')
      fasd -l $queries < /dev/tty > /tmp/fasd.out
      read -zl expansions < /tmp/fasd.out

      if test -n "$expansions"
        printf '%s\n' $expansions
        return
      end

    # Match only directories.
    case 'd,?*'
      set -l queries (echo -n "$token" | cut -b 3- | tr ',' '\n')
      fasd -l $queries < /dev/tty > /tmp/fasd.out
      read -zl expansions < /tmp/fasd.out

      if test -n "$expansions"
        printf '%s\n' $expansions
        return
      end

    # Match only files.
    case 'f,?*'
      set -l queries (echo -n "$token" | cut -b 3- | tr ',' '\n')
      fasd -l $queries < /dev/tty > /tmp/fasd.out
      read -zl expansions < /tmp/fasd.out

      if test -n "$expansions"
        printf '%s\n' $expansions
        return
      end
  end

  # Defer to regular completion.
  return 1
end
