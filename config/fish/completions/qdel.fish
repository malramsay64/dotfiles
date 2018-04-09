complete -c qdel -f -a (qstat -u $USER | grep '.pbss' | cut -d. -f1)
