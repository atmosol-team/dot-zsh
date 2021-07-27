export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export CLICOLOR=true

# Add package ZSH function folders to fpath
func_folders=($ZSH/*/zsh.config.d/functions(N))
for file in $func_folders; do
    fpath=($file $fpath)
done

# Add package ZSH function files to autoload
func_files=($ZSH/*/zsh.config.d/functions/*(N))
for file in $func_files; do
    autoload -U $file(:t)
done

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # Don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # Allow functions to have local options
setopt LOCAL_TRAPS # Allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # Share history between sessions ???
setopt EXTENDED_HISTORY # Add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY # Adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # Adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # Don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE # Don't record commands beginning with a space

# Don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
#setopt complete_aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
