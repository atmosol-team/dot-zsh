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
    if [[ $SHELL =~ /zsh$ ]]; then
        # Aliases
        alias reload!='. ~/.zshrc'  # Reload ZSH
        alias cls='clear'           # Clear screen, the old-fashioned way

        . "$PKG_PATH/init/config.zsh"
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