function tmux-attach
    # 1) Need exactly one argument
    if test (count $argv) -eq 0
        echo "Usage: tmux-attach <session_id>"
        return 1
    end

    # 2) Ensure tmux-list has populated the array
    if test -z "$TMUX_SESSION_NAMES" -o (count $TMUX_SESSION_NAMES) -eq 0
        echo "Session list empty, call 'tmux-list' first, genius."
        return 1
    end

    # 3) Validate it's a non-negative integer
    if not string match -qr '^[0-9]+$' $argv[1]
        echo "Invalid session ID: $argv[1]. Must be a non-negative integer."
        return 1
    end

    set -l id $argv[1]

    # 4) Check array bounds
    if test $id -lt 0 -o $id -ge (count $TMUX_SESSION_NAMES)
        echo "Invalid session ID: $id. Get your act together."
        return 1
    end

    # 5) Grab the session name and attach
    set -l session_name $TMUX_SESSION_NAMES[$id+1]
    echo "Attaching to session: $session_name"
    tmux attach-session -t "$session_name"
end