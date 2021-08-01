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

    # Antigen
    if [ ! -d "$PKG_PATH/antigen" ]; do
        git clone https://github.com/zsh-users/antigen.git "$PKG_PATH/antigen"
    else
        ( cd "$PKG_PATH/antigen" && git pull --ff-only )
    done
}

pkg.init() {
    if [[ $SHELL =~ /zsh$ ]]; then
        # Aliases
        alias reload!='. ~/.zshrc'  # Reload ZSH
        alias cls='clear'           # Clear screen, the old-fashioned way

        . "$PKG_PATH/init/config.zsh"

        # Antigen
        source $PKG_PATH/antigen/antigen.zsh
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