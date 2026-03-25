# Machine Setup Guide

> Auto-generated from current machine state. This document helps you rebuild your development environment on a new machine.

## Quick Start

```bash
# 1. Install Homebrew (see below)
# 2. Install all brew packages: brew bundle --file=Brewfile
# 3. Install global npm packages (see Node.js section)
# 4. Install uv tools (see Python section)
# 5. Install other standalone tools (see sections below)
# 6. Clone and stow dotfiles
```

---

## Core Infrastructure

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Taps used:**

```
codecrafters-io/tap
encoredev/tap
erictli/tap
felixkratz/formulae
geldata/tap
glinford/tap
libsql/sqld
nikitabobko/tap
pulumi/tap
sst/tap
steipete/tap
stripe/stripe-cli
tursodatabase/tap
tw93/tap
withgraphite/tap
```

### Shell Setup

**Fish Shell** (primary shell):

```bash
brew install fish
# Add to /etc/shells: echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
# Change default: chsh -s /opt/homebrew/bin/fish
```

**Zsh** (backup):

```bash
brew install bash  # Updated bash
# macOS ships with zsh
```

---

## Terminal & CLI Tools

### Essential CLI Tools

```bash
brew install \
  starship \
  fzf \
  zoxide \
  atuin \
  bat \
  fd \
  ripgrep \
  eza \
  htop \
  jq \
  just \
  tree \
  cloc \
  git \
  git-delta \
  lazygit \
  gh \
  onefetch
```

**Atuin** (shell history):

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# Or: brew install atuin
```

### Terminal Multiplexers

```bash
brew install tmux zellij
```

**Tmux Plugin Manager (TPM):**

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

**Tmux plugins used:**

- tmux-plugins/tmux-sensible
- thewtex/tmux-mem-cpu-load
- tmux-workspace-usage (custom)

### File Managers

```bash
brew install yazi
```

### Database Tools

```bash
brew install \
  lazysql \
  dbmate \
  postgresql@18 \
  mysql \
  turso \
  sqld
```

### Modern Replacements

```bash
brew install \
  television  # fzf alternative (tv) \
  borders     # macOS window borders
```

---

## Terminal Emulators

```bash
brew install --cask \
  alacritty \
  ghostty \
  iterm2
```

---

## Development Languages & Runtimes

### Node.js Ecosystem

**Node via Homebrew:**

```bash
brew install node pnpm yarn
```

**Bun (preferred runtime):**

```bash
curl -fsSL https://bun.sh/install | bash
```

**Global npm packages** (install with `npm i -g`):

```
@anthropic-ai/claude-code
@google/gemini-cli
@letta-ai/letta-code
@mariozechner/pi-coding-agent
@qwen-code/qwen-code
@sourcegraph/amp
agent-browser
hunkdiff
node-gyp
npm
openlogs
playwriter
typescript-language-server
typescript
```

**Global Bun packages** (install with `bun add -g`):

```
@anthropic-ai/claude-code
@oh-my-pi/pi-coding-agent
@openai/codex
```

### Python Ecosystem

**uv (preferred Python manager):**

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**uv tools installed:**

```bash
uv tool install aider-chat
uv tool install kimi-cli
uv tool install llm-tldr
uv tool install ruff
```

**Poetry** (legacy):

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

### Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Cargo tools:**

```bash
cargo install  # (none currently - using brew alternatives)
```

### Go

```bash
brew install go golang-migrate
```

**Go tools:**

```bash
go install golang.org/x/tools/gopls@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
```

### Elixir/Erlang

```bash
brew install erlang elixir rebar3
```

### Gleam

```bash
brew install gleam
```

### Other Languages

```bash
brew install \
  lua \
  luajit \
  luarocks \
  typst
```

---

## Editors

### Neovim

```bash
brew install neovim
```

**Plugin manager:** lazy.nvim (auto-installed)

**Tree-sitter:** Included with nvim

---

## AI Coding Assistants

### CLI Agents

```bash
# Claude Code (npm)
npm install -g @anthropic-ai/claude-code

# Codex (Bun)
bun add -g @openai/codex

# Gemini CLI (npm)
npm install -g @google/gemini-cli

# Pi Coding Agent (npm)
npm install -g @mariozechner/pi-coding-agent

# Oh My Pi (Bun)
bun add -g @oh-my-pi/pi-coding-agent

# Qwen Code (npm)
npm install -g @qwen-code/qwen-code

# Letta Code (npm)
npm install -g @letta-ai/letta-code

# Aider (uv)
uv tool install aider-chat

# Kimi CLI (uv)
uv tool install kimi-cli
```

### Desktop Apps

### Other AI Tools

```bash
npm install -g playwriter      # Playwright browser control
```

---

## Cloud & DevOps

### Databases & Services

```bash
brew install \
  cloudflared \
  ngrok \
  stripe/stripe-cli/stripe \
  railway
```

### Container/VM Tools

```bash
brew install --cask orbstack  # Docker alternative
```

---

## macOS Window Management

```bash
brew install --cask \
  aerospace \
  flashspace \
  hammerspoon \
  alt-tab \
  jordanbaird-ice  # Menu bar manager
```

**SketchyBar** (optional status bar):

```bash
brew install sketchybar
```

---

## Fonts

```bash
brew install --cask \
  font-3270-nerd-font \
  font-cascadia-code-nf \
  font-geist \
  font-hack-nerd-font \
  font-iosevka \
  font-jetbrains-mono-nerd-font \
  font-monaspace
```

---

## Utilities

### macOS Apps

```bash
brew install --cask \
  1password-cli \
  android-platform-tools \
  basictex \
  dns-easy-switcher \
  localsend \
  marta \
  pearcleaner \
  pika \
  scratch \
  stats \
  tailscale
```

### CLI Utilities

```bash
brew install \
  ffmpeg \
  imagemagick \
  pandoc \
  telnet \
  exercism \
  codecrafters \
  encore \
  gel-cli \
  graphite \
  git-who \
  jj
```

---

## Other Standalone Tools

### Vite+ (custom tool)

```bash
curl -fsSL https://vite.plus | bash
```

### OpenCode

```bash
curl -fsSL https://opencode.ai/install | bash
```

---

## Dotfiles Setup

```bash
# 1. Clone dotfiles
git clone https://github.com/affantaufiqur/dotfiles.git ~/dotfiles

# 2. Install stow
brew install stow

# 3. Stow configurations
cd ~/dotfiles
stow .
```

---

## Verification Checklist

After setup, verify these work:

- [ ] `fish --version`
- [ ] `nvim --version`
- [ ] `tmux -V`
- [ ] `bun --version`
- [ ] `node --version`
- [ ] `uv --version`
- [ ] `cargo --version`
- [ ] `go version`
- [ ] `claude --version`
- [ ] `codex --version`
- [ ] `starship --version`
- [ ] Ghostty/Alacritty launch
- [ ] Tmux plugins load (`prefix + I`)

---

## Notes

- **Node version management**: You're using Homebrew's node directly
- **Python**: Using `uv` exclusively (no pyenv)
- **PostgreSQL**: Using Homebrew's postgresql@18 (not Postgres.app)
- **Shell**: Fish is primary, with Zsh as backup
- **Package managers**: Prefer `brew` > `uv` > `bun` > `npm` for global tools

---

_Last updated: 2026-03-25_
