# Load environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=~/.npm-global/bin:$PATH

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bold,underline"
source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# FZF
# Source FZF if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Full-screen mode & better UI
export FZF_DEFAULT_OPTS="
  --height=100% --border
  --preview 'ls -lh --color=auto {} 2>/dev/null'
  --preview-window=right:60%:wrap
  --bind 'ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard)'
  --bind 'ctrl-t:toggle-preview'
"

# FZF file search (Ctrl+T)
fzf-file-widget() {
  BUFFER=$(find . -type f 2>/dev/null | fzf)
  CURSOR=$#BUFFER
}
zle -N fzf-file-widget
bindkey '^T' fzf-file-widget

# FZF directory search with tree preview (Ctrl+F)
fzf-cd-widget() {
  local dir
  dir=$(find . -type d 2>/dev/null | \
    fzf --preview 'tree -C {}' --preview-window=right:60%) || return
  cd "$dir" || return
  zle reset-prompt
}
zle -N fzf-cd-widget
bindkey '^F' fzf-cd-widget
bindkey '^Y' vi-end-of-line
# Path
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/snorpiii/.bun/_bun" ] && source "/home/snorpiii/.bun/_bun"

alias vim='nvim'
export PATH="/home/snorpiii/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/snorpiii/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PATH=$HOME/.fly/bin:$PATH
export PATH=$PATH:$HOME/go/bin
export PATH="$HOME/.local/bin:$PATH"
# pnpm
export PNPM_HOME="/home/snorpiii/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
alias brave='brave --password-store=basic'

# Claude Code Shortcuts - Updated with Opus 4.6
alias ccode='claude code'
alias csonnet='claude code --model claude-sonnet-4-5-20250929'
alias copus='claude code --model claude-opus-4-6-20250514'  # ✨ Updated to 4.6
alias copus45='claude code --model claude-opus-4-5-20251101'  # Keep 4.5 for compatibility
alias chaiku='claude code --model claude-haiku-4-5-20251001'

# Claude Code with Agents
alias csonnet-bash='claude code --model claude-sonnet-4-5-20250929 --agent bash'
alias csonnet-edit='claude code --model claude-sonnet-4-5-20250929 --agent edit'
alias copus-bash='claude code --model claude-opus-4-6-20250514 --agent bash'  # ✨ Updated
alias copus-edit='claude code --model claude-opus-4-6-20250514 --agent edit'  # ✨ Updated

# Quick documentation generation
alias cdoc='claude code --model claude-sonnet-4-5-20250929 "Create comprehensive documentation"'

# Function for quick prompts with different models
cask() {
    local model="${1:-sonnet}"
    local prompt="${@:2}"
    
    case $model in
        sonnet|s)
            claude code --model claude-sonnet-4-5-20250929 "$prompt"
            ;;
        opus|o)
            claude code --model claude-opus-4-6-20250514 "$prompt"  # ✨ Updated
            ;;
        opus45)
            claude code --model claude-opus-4-5-20251101 "$prompt"
            ;;
        haiku|h)
            claude code --model claude-haiku-4-5-20251001 "$prompt"
            ;;
        *)
            echo "Usage: cask [sonnet|opus|opus45|haiku] 'your prompt here'"
            echo "Short: cask [s|o|h] 'your prompt here'"
            ;;
    esac
}

# Helper function to show available Claude shortcuts
claude-help() {
    echo "🤖 Claude Code Shortcuts:"
    echo ""
    echo "Basic Commands:"
    echo "  ccode          - claude code (default model)"
    echo "  csonnet        - Claude Sonnet 4.5"
    echo "  copus          - Claude Opus 4.6 (Latest) ✨"
    echo "  copus45        - Claude Opus 4.5 (Previous)"
    echo "  chaiku         - Claude Haiku 4.5"
    echo ""
    echo "With Agents:"
    echo "  csonnet-bash   - Sonnet with bash agent"
    echo "  csonnet-edit   - Sonnet with edit agent"
    echo "  copus-bash     - Opus 4.6 with bash agent ✨"
    echo "  copus-edit     - Opus 4.6 with edit agent ✨"
    echo ""
    echo "Quick Functions:"
    echo "  cask s 'prompt'    - Quick Sonnet prompt"
    echo "  cask o 'prompt'    - Quick Opus 4.6 prompt ✨"
    echo "  cask opus45 'p'    - Quick Opus 4.5 prompt"
    echo "  cask h 'prompt'    - Quick Haiku prompt"
    echo "  cdoc               - Quick documentation generation"
    echo ""
    echo "Model Info:"
    echo "  Sonnet 4.5  - Fast, efficient, best for daily tasks"
    echo "  Opus 4.6    - Most capable, latest (May 2025) ✨"
    echo "  Opus 4.5    - Previous version (Nov 2024)"
    echo "  Haiku 4.5   - Fastest, cheapest"
    echo ""
    echo "Examples:"
    echo "  csonnet 'explain this code'"
    echo "  copus 'create complex architecture with Opus 4.6'"
    echo "  cask o 'analyze and refactor this service'"
    echo "  copus-bash 'optimize deployment pipeline'"
}
alias brave-dev="pkill -f brave; sleep 1; brave --explicitly-allowed-ports=6000 &"
