# NVM setup
set -x NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"
    # NVM needs bash compatibility wrapper
    function nvm
        bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm $argv
    end
end

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

# Postgres.app on macOS
fish_add_path -a "/Applications/Postgres.app/Contents/Versions/latest/bin"

# Bun setup
set -x BUN_INSTALL "$HOME/.bun"
fish_add_path -a "$BUN_INSTALL/bin"

# fnm setup (Linux and macOS)
set -l fnm_linux "$HOME/.local/share/fnm"
set -l fnm_macos "$HOME/Library/Application Support/fnm"

if test -d $fnm_linux
    fish_add_path -a "$fnm_linux"
    fnm env | source
else if test -d $fnm_macos
    fish_add_path -a "$fnm_macos"
    fnm env | source
end

# ASDF shims
if set -q ASDF_DATA_DIR
    fish_add_path -p "$ASDF_DATA_DIR/shims"
else
    fish_add_path -p "$HOME/.asdf/shims"
end

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

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
