ssh-agent -c 
    | split row ';' 
    | split column ' ' 
    | first 2 
    | select column2 column3 
    | rename variable value 
    | reduce -f {} {|it, acc| $acc | upsert $it.variable $it.value } 
    | load-env
