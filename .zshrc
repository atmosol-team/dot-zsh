# Source Ellipsis init code or fallback to the older system
if [ -f ~/.ellipsis/init.sh ]; then
    . ~/.ellipsis/init.sh
else
    export PATH="$PATH:~/.ellipsis/bin"
fi

# Shortcut to shared ZSH config path is $ZSH
export ZSH=$ELLIPSIS_PACKAGES

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# All of our zsh files
typeset -U config_files
config_files=($ZSH/*/zsh.config.d/*.zsh)

# Load all path.zsh files first
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# Initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# Load ZSH first -- everything but the path, completion, and logout files
for file in ${(M)${${${config_files:#*/path.zsh}:#*/completion.zsh}:#*/logout.zsh}:#*/zsh/*}
do
  source $file
done

# Load everything else -- everything but the path, completion, and logout files
for file in ${${${${config_files:#*/path.zsh}:#*/completion.zsh}:#*/logout.zsh}:#*/zsh/*}
do
  source $file
done

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
