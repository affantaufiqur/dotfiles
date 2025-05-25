function Get-GitWorktreeRemove
    set -l Path $argv[1]
    set -l branchName (basename $Path)
    git worktree remove "$Path"
    echo "Worktree removed"
    git branch -D "$branchName"
end