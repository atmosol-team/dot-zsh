export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Match lowercase case-insensitively
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Prevent autocompletion from triggering when pasting
zstyle ':completion:*' insert-tab pending

# Source Ellipsis init code or fallback to the older system
if [ -f ~/.ellipsis/init.sh ]; then
    . ~/.ellipsis/init.sh
else
    export PATH="$PATH:~/.ellipsis/bin"
fi

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
