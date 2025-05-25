function Get-GitPull
    set -l Branch $argv[1]
    git pull origin "$Branch"
end