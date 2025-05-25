function Get-GitAddCommit
    set -l Message $argv[1]
    git add . && git commit -m "$Message"
end