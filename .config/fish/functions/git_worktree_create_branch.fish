function git_worktree_create_branch
    set -l Path $argv[1]
    set -l branchName (basename $Path)
    git worktree add -b "$branchName" "$Path"
    
    set -l untracked (git ls-files --others --directory)
    for file in $untracked
        set -l src (realpath "$file") 
        set -l dst "$Path/$file"
        
        if test -d $src
            test ! -d $dst; and mkdir -p "$dst"
        else
            cp -f "$src" "$dst"
        fi
    end
    
    cd "$Path"
end