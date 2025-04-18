export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && \
  source "$HOME/.opam/opam-init/init.zsh" &> /dev/null

# Local bin first
export PATH=$HOME/.local/bin:$PATH

# Homebrew (Intel/M1)
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"
elif [[ -d /usr/local/bin ]]; then
  export PATH="$PATH:/usr/local/bin:/usr/local/sbin"
fi

# Postgres.app on macOS
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# fnm (Linux)
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d $FNM_PATH ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# fnm (macOS)
FNM_PATH="$HOME/Library/Application Support/fnm"
if [[ -d $FNM_PATH ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# ASDF shims
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# exercism, qrc, npm‑global
export PATH=~/bin:$PATH
export PATH=$PATH:/home/ikan/code/qrc/target/release
export PATH=~/.npm-global/bin:$PATH
