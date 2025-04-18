function Get-GitStatus() {
  git status -sb
}
function Get-GitCheckoutNewBranch() {
  git checkout -b "$@"
}
function Get-GitCheckoutBranch() {
  git checkout "$@"
}
function Get-GitWorktreeAdd() {
  local Path=$1 Branch=$2
  git worktree add "$Path" "$Branch"
}
function git_worktree_create_branch() {
  local Path="$1" branchName="${Path##*/}"
  git worktree add -b "$branchName" "$Path"
  local untracked=$(git ls-files --others --directory)
  local -a files=("${(f)untracked}")
  for file in "${files[@]}"; do
    local src=$(realpath "$file") dst="$Path/$file"
    if [[ -d $src ]]; then
      [[ ! -d $dst ]] && mkdir -p "$dst"
    else
      cp -f "$src" "$dst"
    fi
  done
  cd "$Path"
}
function Get-GitWorktreeList() { git worktree list; }
function Get-GitWorktreeRemove() {
  local Path=$1 branchName="${Path##*/}"
  git worktree remove "$Path"
  print "Worktree removed"
  git branch -D "$branchName"
}
function Get-GitFetchAll() { git fetch -a; }
function Get-GitBranchList() { git branch -a -l; }
function Get-GitPull() {
  local Branch=$1
  git pull origin "$Branch"
}
function Get-GitAddCommit() {
  local Message=$1
  git add . && git commit -m "$Message"
}
function Get-GitBranchDeleteForce() {
  local Branch=$1
  git branch -D "$Branch"
}


tmux-detach() {
  if [[ -n "$TMUX" ]]; then
    echo "Detaching from tmux session..."
    tmux detach
  else
    echo "Not inside a tmux session, mate. Chill."
  fi
}

# List tmux sessions with indexed IDs
tmux-list() {
  local -a sessions names
  local sessions_txt names_txt
  local i

  # 1) Capture the full session info in one go
  sessions_txt=$(
    tmux list-sessions \
      -F '#{session_name} #{session_windows} windows, #{session_attached} attached'
  )

  # 2) Split on newlines into the array
  sessions=( "${(@f)sessions_txt}" )

  # 3) Bail if empty
  if (( ${#sessions} == 0 )); then
    print "No tmux sessions found, ya muppet."
    return 1
  fi

  # 4) Print them with a 0‑based index
  print "Available tmux sessions:"
  for (( i = 1; i <= ${#sessions}; i++ )); do
    print "[$(( i - 1 ))] ${sessions[i]}"
  done

  # 5) Now grab just the names
  names_txt=$(
    tmux list-sessions -F '#{session_name}'
  )
  names=( "${(@f)names_txt}" )

  # 6) Export globally
  typeset -ga TMUX_SESSION_NAMES
  TMUX_SESSION_NAMES=( "${names[@]}" )
}

# Attach to tmux session by ID
tmux-attach() {
  # 1) Need exactly one argument
  if (( $# == 0 )); then
    print "Usage: tmux-attach <session_id>"
    return 1
  fi

  # 2) Ensure tmux-list has populated the array
  if (( ${#TMUX_SESSION_NAMES[@]} == 0 )); then
    print "Session list empty, call 'tmux-list' first, genius."
    return 1
  fi

  # 3) Validate it’s a non‑negative integer
  if [[ ! $1 =~ '^[0-9]+$' ]]; then
    print "Invalid session ID: $1. Must be a non-negative integer."
    return 1
  fi

  local id=$1
  # 4) zsh arrays are 1-based, so bump it
  local idx=$(( id + 1 ))

  # 5) Out‑of‑range?
  if (( idx < 1 || idx > ${#TMUX_SESSION_NAMES[@]} )); then
    print "Invalid session ID: $id. Get your act together."
    return 1
  fi

  # 6) Grab the session name and attach
  local session_name=${TMUX_SESSION_NAMES[idx]}
  print "Attaching to session: $session_name"
  tmux attach-session -t "$session_name"
}
