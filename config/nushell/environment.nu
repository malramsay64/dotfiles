let-env PATH = [
    $env.PATH,
    ("~/go/bin" | path expand),
    ("~/.cargo/bin" | path expand)
]

let-env ZK_NOTEBOOK_DIR = ("~/Documents/notes" | path expand)

alias c = clear