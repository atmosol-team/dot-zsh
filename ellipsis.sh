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
}

pkg.init() {
    # Only run if we're running inside ZSH
    if [[ "$(ps -p $$ -o command=)" = "zsh" ]]; then
        # Load all *.zsh files in the init folder
        for file in $PKG_PATH/init/*[.]zsh; do
            . "$file"
        done
    fi
}

pkg.link() {
    fs.link_file .zshrc
}

pkg.unlink() {
    if [ -L "$HOME/.zshrc" ] && [ "$(readlink $HOME/.zshrc)" = "$PKG_PATH/.zshrc" ]; then
        rm "$HOME/.zshrc"
    fi
}