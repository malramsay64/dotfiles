# Code generated by zoxide. DO NOT EDIT.

# =============================================================================
#
# Utility functions for zoxide.
#

# Default prompt for Nushell.
let-env __zoxide_oldprompt = (if '__zoxide_oldprompt' in (env).name {
  $env.__zoxide_oldprompt
} else {
  if 'PROMPT_COMMAND' in (env).name {
    $env.PROMPT_COMMAND
  } else {
    __zoxide_undefined
  }
})

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
def __zoxide_hook [] {
  zoxide add -- $env.PWD
}

# Initialize hook.
let-env PROMPT_COMMAND = {
  __zoxide_hook
  do $env.__zoxide_oldprompt
}

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
def-env __zoxide_z [...rest:string] {
  # `z -` doesn't work yet, see https://github.com/nushell/nushell/issues/4769
  let arg0 = ($rest | append '~').0
  let path = if ($rest | length) <= 1 and ($arg0 | path expand | path type) == dir {
    $arg0
  } else {
    (zoxide query --exclude $env.PWD -- $rest | str trim -r -c (char newline))
  }
  cd $path
  echo $env.PWD
}

# Jump to a directory using interactive search.
def-env __zoxide_zi  [...rest:string] {
  cd $'(zoxide query -i -- $rest | str trim -r -c (char newline))'
  echo $env.PWD
}

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

alias z = __zoxide_z
alias zi = __zoxide_zi

# =============================================================================
# To initialize zoxide, first generate the Nushell initialization script (you
# may need to do this whenever you update Nushell):
#
#   zoxide init nushell --hook prompt | save ~/.zoxide.nu
#
# Now, add this to your configuration (find it by running `$nu.config-path` in
# Nushell):
#
#   zoxide init nushell --hook prompt | save ~/.zoxide.nu
#   source ~/.zoxide.nu
#
# Note: zoxide only supports Nushell v0.59.0 and above.
