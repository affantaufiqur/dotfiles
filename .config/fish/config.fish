# PNPM setup
set -x PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path -p "$PNPM_HOME"

# Setup FZF if available
if test -f ~/.fzf.fish
    source ~/.fzf.fish
end

# Path additions - mimicking ZSH setup
set -x GOPATH $HOME/go
fish_add_path -a /usr/local/go/bin "$GOPATH/bin"

# OPAM setup
if test -r "$HOME/.opam/opam-init/init.fish"
    source "$HOME/.opam/opam-init/init.fish" >/dev/null 2>&1
end

# Local bin first
fish_add_path -p "$HOME/.local/bin"

# Homebrew paths
if test -d /opt/homebrew/bin
    fish_add_path -a /opt/homebrew/bin /opt/homebrew/sbin
else if test -d /usr/local/bin
    fish_add_path -a /usr/local/bin /usr/local/sbin
end

# Postgres.app on macOS (removed, using brew instead)
# fish_add_path -a "/Applications/Postgres.app/Contents/Versions/latest/bin"

# PostgreSQL 18 from Homebrew
fish_add_path -a "/opt/homebrew/opt/postgresql@18/bin"

# Bun setup
set -x BUN_INSTALL "$HOME/.bun"
fish_add_path -a "$BUN_INSTALL/bin"

set -gx PATH $HOME/.local/share/uv/python $PATH

# Additional paths
fish_add_path -a "$HOME/bin"
fish_add_path -a /home/ikan/code/qrc/target/release
fish_add_path -a "$HOME/.npm-global/bin"

# Load fish_plugins if it exists (for Fisher)
if test -f ~/.config/fish/fish_plugins
    source ~/.config/fish/fish_plugins
end

# Use starship prompt if installed
if type -q starship
    starship init fish | source
end

# Initialize zoxide if installed
if type -q zoxide
    zoxide init fish | source
end

# Cargo
set -x CARGO_HOME $HOME/.cargo

set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Added by Windsurf
fish_add_path /Users/affan/.codeium/windsurf/bin

# opencode
fish_add_path /Users/affan/.opencode/bin

# Tmux work alias
alias tmux-work="$HOME/dotfiles/.local/bin/tmux-work"

# Vite+ bin (https://viteplus.dev)
source "$HOME/.vite-plus/env.fish"

# pi - force a direct vite-plus managed Node >= 22 (ignores project .node-version)
function __pi_vite_node
    set -l node_root $HOME/.vite-plus/js_runtime/node

    for ver in (command ls -1 $node_root 2>/dev/null | string match -r '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -t. -k1,1nr -k2,2nr -k3,3nr)
        set -l major (string split '.' $ver)[1]
        if test $major -ge 22
            set -l candidate $node_root/$ver/bin/node
            if test -x $candidate
                echo $candidate
                return 0
            end
        end
    end

    return 1
end

# Debug helper: show Node version/path that pi will use
function pi-node
    set -l _pi_node (__pi_vite_node)
    if test -z "$_pi_node"
        echo "pi-node: no vite-plus Node >= 22 found" >&2
        return 1
    end
    command $_pi_node -e 'console.log(process.version + " " + process.execPath)'
end

function pi
    set -l _pi_node (__pi_vite_node)
    if test -z "$_pi_node"
        echo "pi: could not find a vite-plus Node >= 22 in $HOME/.vite-plus/js_runtime/node" >&2
        return 1
    end

    # Call pi CLI directly with the chosen Node binary (bypasses /usr/bin/env node)
    command $_pi_node $HOME/.npm-global/lib/node_modules/@mariozechner/pi-coding-agent/dist/cli.js $argv
end
