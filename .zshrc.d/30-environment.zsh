export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH";; esac

function copilot() {
  gh copilot explain "$1"
}

# zoxide is now managed by zinit in 02-plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
