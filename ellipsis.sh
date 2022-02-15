#!/usr/bin/env bash

pkg.install() {
    if ! utils.cmd_exists zsh; then
        case $(os.platform) in
            osx)
                if utils.cmd_exists brew; then
                    brew install zsh;
                fi
                ;;
            linux|wsl2|wsl1)
                if utils.cmd_exists apt-get; then
                    sudo apt-get -y update;
                    sudo apt-get -y install zsh;
                fi
                ;;
        esac
    fi

    # Detect default shell. If not ZSH, prompt to change.
    case $(os.platform) in
        osx)
            DEFAULT_SHELL="$(dscl . -read $HOME shell | awk -F ' ' '{print $NF}')"
            ;;
        *)
            DEFAULT_SHELL="$(getent passwd $(id -un) | awk -F : '{print $NF}')"
            ;;
    esac
    if [[ (! -f "$PKG_PATH/.no-chsh-prompt") && (! "$DEFAULT_SHELL" =~ zsh) ]]; then
        echo ""
        read -e -p "Change default shell to ZSH? [Y/n/never] " CHANGE_SHELL
        if [[ $CHANGE_SHELL =~ ^[Yy]([Ee][Ss])?$ ]]; then
            chsh -s $(command -v zsh)
        elif [[ $CHANGE_SHELL =~ ^[Nn][Ee][Vv][Ee][Rr]$ ]]; then
            touch "$PKG_PATH/.no-chsh-prompt"
        fi
    fi

    # Zinit (formerly Zplugin)
    if [ ! -d "$PKG_PATH/zinit" ]; then
        git clone https://github.com/zdharma-continuum/zinit.git "$PKG_PATH/zinit"
    else
        zsh $PKG_PATH/zinit/zinit.zsh self-update
    fi

    # Prompt for Nerd font download
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"

    if [ ! -f "$PKG_PATH/.no-font-prompt" ]; then
        echo ""
        read -e -p "Download the Sauce Code Pro Nerd Font? [Y/n/never] " DOWNLOAD_FONT
        if [[ $DOWNLOAD_FONT =~ ^[Yy]([Ee][Ss])?$ ]]; then
            # Look for common browsers/OS support if not set in environment
            browsers=( "explorer.exe" "open" "xdg-open" "gnome-open" "browsh" "w3m" "links2" "links" "lynx" )
            for b in "${browsers[@]}"; do
                if [ "$(command -v $b)" ]; then
                    BROWSER="$b"
                    break
                fi
            done

            if [ -n "$BROWSER" ]; then
                $BROWSER "$FONT_URL"
            else
                echo -e "\nDownload the Sauce Code Pro font here:\n  $FONT_URL\n"
                read -n 1 -s -r -p "Press any key to continue..."
                read -s -t 0 # Clear any extra keycodes (e.g. arrows)
                echo ""
            fi
            touch "$PKG_PATH/.no-font-prompt"
        elif [[ $DOWNLOAD_FONT =~ ^[Nn][Ee][Vv][Ee][Rr]$ ]]; then
            touch "$PKG_PATH/.no-font-prompt"
        fi
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
