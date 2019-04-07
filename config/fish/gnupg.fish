# Start or re-use a gpg-agent.
#
# Assumes gpg-agent writes its environment info in ~/.gpg-agent-info.
#
# Sets the gpg-agent environment stuff as universal variables, so it
# takes effect across all shells.

# GPG agent
#
gpgconf --launch gpg-agent
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -gx GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null
