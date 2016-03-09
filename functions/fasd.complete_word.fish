function fasd.complete_word -d "Binding that provides word expansion"
  # Get the current token to complete
  set -l token (commandline -t)

  # Match the token against valid fasd word completions.
  switch "$token"
    # Match any directory or file.
    case ',?*'
      set -l queries (commandline -t | tr ',' '\n')
      set -l expansion (fasd -l "$queries")

      if test -n "$expansion"
        commandline -t -r "$expansion"
        return
      end

    # Match only directories.
    case 'd,?*'
      set -l queries (commandline -t | cut -b 3- | tr ',' '\n')
      set -l expansion (fasd -d -l "$queries")

      if test -n "$expansion"
        commandline -t -r "$expansion"
        return
      end

    # Match only files.
    case 'f,?*'
      set -l queries (commandline -t | cut -b 3- | tr ',' '\n')
      set -l expansion (fasd -f -l "$queries")

      if test -n "$expansion"
        commandline -t -r "$expansion"
        return
      end
  end

  # Defer to regular completion.
  commandline -f complete
end
