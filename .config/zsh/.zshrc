autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd	

export HISTCONTROL=ignoredups

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey ^R history-incremental-search-backward 
bindkey '^j' vi-cmd-mode

# eval "$(starship init zsh)"
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2> /dev/null
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2> /dev/null
