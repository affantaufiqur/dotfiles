function tmux-list
    # Declare arrays for session info
    set -l sessions
    set -l names
    
    # Capture full session info
    set sessions (tmux list-sessions -F '#{session_name} #{session_windows} windows, #{session_attached} attached' 2>/dev/null)
    
    # Bail if empty
    if test (count $sessions) -eq 0
        echo "No tmux sessions found, ya muppet."
        return 1
    end
    
    # Print them with a 0-based index
    echo "Available tmux sessions:"
    set -l i 0
    for session in $sessions
        echo "[$i] $session"
        set i (math $i + 1)
    end
    
    # Now grab just the names
    set names (tmux list-sessions -F '#{session_name}' 2>/dev/null)
    
    # Export globally (fish uses universal variables instead of global)
    set -g TMUX_SESSION_NAMES $names
end