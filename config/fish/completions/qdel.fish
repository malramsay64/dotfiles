complete -c qdel -f -a "(qstat -u $USER | grep '^[0-9]' | cut -d. -f1)"
