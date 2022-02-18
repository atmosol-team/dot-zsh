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

# Redirect from WSL default directory since linux fs is faster
pwd | grep -E "^/mnt/./Users/[^/]+?$" >/dev/null 2>&1 && cd
echo "$OLDPWD" | grep -E "^/mnt/./Users/[^/]+?$" >/dev/null 2>&1 && cd
