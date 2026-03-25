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
