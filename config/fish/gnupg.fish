# Start or re-use a gpg-agent.
#
# Assumes gpg-agent writes its environment info in ~/.gpg-agent-info.
#
# Sets the gpg-agent environment stuff as universal variables, so it
# takes effect across all shells.

if not set -q -x GPG_AGENT_INFO
    gpg-agent --daemon >/dev/null
    if test $status -eq 0
        set -x GPG_AGENT_INFO present
    end
end

if test -f ~/.gpg-agent-info
    __refresh_gpg_agent_info

    gpg-connect-agent /bye ^/dev/null
    if test $status -eq 1
        pkill -U $USER gpg-agent
        gpg-agent --daemon >/dev/null
        __refresh_gpg_agent_info
    end
end
