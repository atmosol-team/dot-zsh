#!/usr/bin/env bash

pkg.install() {
    if ! utils.cmd_exists zsh; then
        case $(os.platform) in
            osx)
                if utils.cmd_exists brew; then
                    brew install zsh;
                fi
                ;;
            linux)
                if utils.cmd_exists apt-get; then
                    sudo apt-get -y update;
                    sudo apt-get -y install zsh;
                fi
                ;;
        esac
    fi

    # Zplugin
    if [ ! -d "$PKG_PATH/zplugin" ]; then
        git clone https://github.com/zdharma-continuum/zinit.git "$PKG_PATH/zinit"
    else
        $PKG_PATH/zinit/zinit.zsh self-update
    fi
}

pkg.init() {
    # Only run if we're running inside ZSH
    if [[ "$(ps -p $$ -o command=)" =~ "zsh" ]]; then
        # Load all *.zsh files in the init folder
        for file in $PKG_PATH/init/*[.]zsh; do
            . "$file"
        done

        # Zplugin
        if [ -f "$PKG_PATH/zinit/zinit.zsh" ]; then
            source $PKG_PATH/zinit/zinit.zsh
        fi
    fi
}

pkg.link() {
    fs.link_file .zshrc
    fs.link_file .p10k.zsh
}

pkg.unlink() {
    if [ -L "$HOME/.zshrc" ] && [ "$(readlink $HOME/.zshrc)" = "$PKG_PATH/.zshrc" ]; then
        rm "$HOME/.zshrc"
    fi
    if [ -L "$HOME/.p10k.zsh" ] && [ "$(readlink $HOME/.p10k.zsh)" = "$PKG_PATH/.p10k.zsh" ]; then
        rm "$HOME/.p10k.zsh"
    fi
}
