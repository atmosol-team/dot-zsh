#!/usr/bin/env bash

pkg.install() {
    if ! utils.cmd_exists zsh; then
        pkg.pull;
    fi
}

pkg.pull() {
    hooks.pull;

    case $(os.platform) in
        osx)
            if utils.cmd_exists brew; then
                brew install zsh;
            fi
            ;;
        linux)
            if utils.cmd_exists apt-get; then
                DEBIAN_FRONTEND=noninteractive sudo apt-get update;
                DEBIAN_FRONTEND=noninteractive sudo apt-get install zsh;
            fi
            ;;
    esac
    chsh -s $(which zsh);
}