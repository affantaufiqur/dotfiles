# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(... tmux)
# Created by newuser for 5.9
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
ZSH_TMUX_AUTOSTART=true
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

alias ll='ls -la'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$HOME/.local/bin:$PATH

if [[ -d /opt/homebrew/bin ]]; then
  export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/sbin
elif [[ -d /usr/local/bin ]]; then
  export PATH=$PATH:/usr/local/bin:/usr/local/sbin
fi

autoload -U compinit && compinit
eval "$(zoxide init zsh)"

function Get-GitStatus() {
  git status -sb
}
alias gs="Get-GitStatus"

function Get-GitCheckoutNewBranch() {
  git checkout -b "$@"
}
alias gco="Get-GitCheckoutNewBranch"

function Get-GitCheckoutBranch() {
  git checkout "$@"
}
alias gcb="Get-GitCheckoutBranch"

function Get-GitWorktreeAdd() {
  local Path="$1"
  local Branch="$2"
  git worktree add "$Path" "$Branch"
}
alias gwt="Get-GitWorktreeAdd"

function git_worktree_create_branch() {
  local Path="$1"
  local branchName="${Path##*/}"
  git worktree add -b "$branchName" "$Path"
  local untrackedFiles=$(git ls-files --others --directory)

  # Split the output into lines
  local -a untrackedFileArray=("${(f)untrackedFiles}")

  for file in "${untrackedFileArray[@]}"; do
    local sourcePath="$(realpath "$file")"
    local destinationPath="$Path/$file"

    if [ -d "$sourcePath" ]; then
      if [ ! -d "$destinationPath" ]; then
        mkdir -p "$destinationPath"
      fi
    else
      cp -f "$sourcePath" "$destinationPath"
    fi
  done

  cd "$Path"
}
alias gwtb="git_worktree_create_branch"

function Get-GitWorktreeList() {
  git worktree list
}
alias gwl="Get-GitWorktreeList"

function Get-GitWorktreeRemove() {
  local Path="$1"
  local branchName="${Path##*/}"
  git worktree remove "$Path"
  print "Worktree removed"
  git branch -D "$branchName"
}
alias gwr="Get-GitWorktreeRemove"

function Get-GitFetchAll() {
  git fetch -a
}
alias gfa="Get-GitFetchAll"

function Get-GitBranchList() {
  git branch -a -l
}
alias gbl="Get-GitBranchList"

function Get-GitPull() {
  local Branch="$1"
  git pull origin "$Branch"
}
alias gpull="Get-GitPull"

function Get-GitAddCommit() {
  local Message="$1"
  git add .
  git commit -m "$Message"
}
alias gc="Get-GitAddCommit"

function Get-GitBranchDeleteForce() {
  local Branch="$1"
  git branch -D "$Branch"
}
alias gbd="Get-GitBranchDeleteForce"

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# pnpm
export PNPM_HOME="/home/ikan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# exercism
export PATH=~/bin:$PATH

#qrc
export PATH=$PATH:/home/ikan/code/qrc/target/release

function copilot() {
  gh copilot explain $1
}
alias copilot="copilot"

# bun completions
[ -s "/home/ikan/.bun/_bun" ] && source "/home/ikan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
FNM_PATH="/home/ikan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ikan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man:$MANPATH"
export INFOPATH="/opt/homebrew/share/info:$INFOPATH"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/ikan/.opam/opam-init/init.zsh' ]] || source '/home/ikan/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# fnm
FNM_PATH="/Users/affan/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/affan/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi
