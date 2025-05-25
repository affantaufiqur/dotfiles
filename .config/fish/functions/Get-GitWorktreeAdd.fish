function Get-GitWorktreeAdd
    set -l Path $argv[1]
    set -l Branch $argv[2]
    git worktree add "$Path" "$Branch"
end