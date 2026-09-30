# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Set Zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

#Download zinit if not installed
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Add zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#history setup
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

alias ls="eza --color=always --group-directories-first"

## NVIM alias and default editor
alias vi="nvim"
alias vim="nvim"
export EDITOR=nvim

################# VERSION MANAGERS ################

# pnpm
export PNPM_HOME='/Users/lisandro.bertoli/Library/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/lisandro.bertoli/.bun/_bun" ] && source "/Users/lisandro.bertoli/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"

### Promofarma exclusive conf ###
# Android
export PATH=~/Library/Android/sdk/platform-tools:$PATH
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"

# Google Cloud SDK
[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/path.zsh.inc" ] && source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/path.zsh.inc"
[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/completion.zsh.inc" ] && source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/completion.zsh.inc"

# AWS
export AWS_SESSION_TOKEN_TTL=12h
export AWS_CHAINED_SESSION_TOKEN_TTL=12h
export AWS_MFA_SERIAL=arn:aws:iam::485220025793:mfa/lisandro.bertoli-phone

# Jira
export JIRA_BASE_URL="https://docmorrisgroup.atlassian.net"
export JIRA_EMAIL="lisandro.bertoli2@promocionesfarma.com"

# Tools
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH=$PATH:$HOME/.maestro/bin
### end Promofarma ###

# Secrets (not versioned)
[ -f "$HOME/.secrets.zsh" ] && source "$HOME/.secrets.zsh"
