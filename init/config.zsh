alias cls='clear' # Good 'ol Clear Screen command

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export CLICOLOR=true

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# General ZSH options
#setopt NO_BG_NICE # Don't nice background tasks
setopt NO_HUP # Don't hang up background tasks when shell exits
setopt NO_BEEP # Don't beep on tab completions
#setopt NO_LIST_BEEP # Only beep on ambiguous tab completions
setopt LOCAL_OPTIONS # Allow functions to have local options
setopt LOCAL_TRAPS # Allow functions to have local traps
setopt PROMPT_SUBST # Allow substitutions in ZSH prompt
setopt CORRECT # Let Zsh prompt corrections for missing commands
setopt COMPLETE_IN_WORD # Attempt tab completion at cursor position, e.g. foo|ar
setopt IGNORE_EOF # Ignore hangup signal (Ctrl+D)

# History options
setopt HIST_VERIFY # Display completed substitutions to command before executing
setopt SHARE_HISTORY # Share history between sessions ???
setopt EXTENDED_HISTORY # Add timestamps to history
setopt HIST_IGNORE_ALL_DUPS  # Don't record dupes in history
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks from lines of history
setopt HIST_IGNORE_SPACE # Don't record commands beginning with a space

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
