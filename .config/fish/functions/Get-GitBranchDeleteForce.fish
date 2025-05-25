function Get-GitBranchDeleteForce
    set -l Branch $argv[1]
    git branch -D "$Branch"
end