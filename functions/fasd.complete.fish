function fasd.complete
  command fasd -s $argv | awk '{print $2 "\t" $1}'
end
