# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
def __zoxide_hook [] {
    zoxide add -- $(pwd)
}

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
def __zoxide_z [...rest:string] {
    if $(echo $rest | length) == 1 {
        cd ~
    } {
        let args = $(echo $rest | skip 1);
        if $(echo $args | length) == 1 {
            let arg0 = $(echo $args | first 1);
            if $arg0 == '-' {
                cd -
            } {
                if $(echo $arg0 | path exists) {
                    cd $arg0
                } {
                    cd $(zoxide query --exclude $(pwd) -- $args | str trim)
                }
            }
        } {
            cd $(zoxide query --exclude $(pwd) -- $args | str trim)
        }
    }
}

# Jump to a directory using interactive search.
def __zoxide_zi  [...rest:string] {
    let args = $(echo $rest | skip 1)
    cd $(zoxide query -i -- $args | str trim)
}

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

alias z = __zoxide_z ''
alias zi = __zoxide_zi ''

# =============================================================================
#
# To initialize zoxide with Nushell:
#
# Initialize zoxide's Nushell script:
#
#   zoxide init nushell --hook prompt | save ~/.zoxide.nu
#
# Then, in your Nushell configuration file:
# - Prepend `__zoxide_hook;` to the `prompt` variable.
# - Add the following lines to the `startup` variable:
#   - `zoxide init nushell --hook prompt | save ~/.zoxide.nu`
#   - `source ~/.zoxide.nu`
