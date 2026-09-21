# ~/.zshrc

# 1) Instant prompt (keep as first thing)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/\
p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/\
p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2) Source everything in ~/.zshrc.d in order
ZSHRC_D="$HOME/.zshrc.d"
if [[ -d $ZSHRC_D ]]; then
  for f in $ZSHRC_D/*.zsh; do
    [[ -r $f ]] && source "$f"
  done
fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

. "$HOME/.limbo/env"

[[ -f "$HOME/.config/kaku/zsh/kaku.zsh" ]] && source "$HOME/.config/kaku/zsh/kaku.zsh" # Kaku Shell Integration

# >>> forge initialize >>>
# !! Contents within this block are managed by 'forge zsh setup' !!
# !! Do not edit manually - changes will be overwritten !!

# Add required zsh plugins if not already present
if [[ ! " ${plugins[@]} " =~ " zsh-autosuggestions " ]]; then
    plugins+=(zsh-autosuggestions)
fi
if [[ ! " ${plugins[@]} " =~ " zsh-syntax-highlighting " ]]; then
    plugins+=(zsh-syntax-highlighting)
fi

# Load forge shell plugin (commands, completions, keybindings) if not already loaded
if [[ -z "$_FORGE_PLUGIN_LOADED" ]]; then
    eval "$(forge zsh plugin)"
fi

# Load forge shell theme (prompt with AI context) if not already loaded
if [[ -z "$_FORGE_THEME_LOADED" ]]; then
    eval "$(forge zsh theme)"
fi

# Editor for editing prompts (set during setup)
# To change: update FORGE_EDITOR or remove to use $EDITOR
export FORGE_EDITOR="nvim"
# <<< forge initialize <<<

. "/Users/affan/.deno/env"

# >>> otty shell integration >>>
# Added by Otty — toggle in Settings > Shell > Shell Integration.
# Inert unless launched by Otty (it sets $OTTY_SHELL_INTEGRATION).
if [ -n "$OTTY_SHELL_INTEGRATION" ] && [ -r "$OTTY_SHELL_INTEGRATION/otty-integration.zsh" ]; then
  . "$OTTY_SHELL_INTEGRATION/otty-integration.zsh"
fi
# <<< otty shell integration <<<
source /Users/affan/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
