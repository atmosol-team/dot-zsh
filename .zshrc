# Source Ellipsis init code or fallback to the older system
if [ -f ~/.ellipsis/init.sh ]; then
    . ~/.ellipsis/init.sh
else
    export PATH="$PATH:~/.ellipsis/bin"
fi

# Zplugin
source ~/.p10k.zsh
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
