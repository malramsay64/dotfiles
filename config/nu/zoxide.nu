# =============================================================================
#
# Utility functions for zoxide.
#

# Default prompt for Nushell.
# Taken from: <https://github.com/nushell/nushell/blob/main/docs/sample_config/config.toml>
def __zoxide_prompt [] {
    build-string $(ansi gb) $(pwd) $(ansi reset) '(' $(ansi cb) $(do -i { git rev-parse --abbrev-ref HEAD } | str trim) $(ansi reset) ')' $(ansi yb) $(date format '%m/%d/%Y %I:%M:%S%.3f %p') $(ansi reset) '> '
}

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
# To initialize zoxide, first create a Nushell script:
#
#   zoxide init nushell --hook prompt | save ~/.zoxide.nu
#
# Add this to your configuration (usually ~/.config/nu/config.toml):
#
#   prompt = "__zoxide_hook;__zoxide_prompt"
#   startup = ["zoxide init nushell --hook prompt | save ~/.zoxide.nu", "source ~/.zoxide.nu"]
#
# You can replace __zoxide_prompt with a custom prompt.
