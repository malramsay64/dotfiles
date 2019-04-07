#! /usr/bin/fish
#
if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...

  abbr g 'git'
  abbr gap 'git add -p'
  abbr qsu 'qstat -u $USER'
  abbr qs 'qstat -Jt -u $USER'
  abbr c 'clear'
  abbr isntall 'install'

  echo 'Done'
end

if [ -n "$NVIM_LISTEN_ADDRESS" ]
    alias "nvim" "nvr"
end
