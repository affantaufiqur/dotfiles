function tmux-detach
    if set -q TMUX
        echo "Detaching from tmux session..."
        tmux detach
    else
        echo "Not inside a tmux session, mate. Chill."
    end
end