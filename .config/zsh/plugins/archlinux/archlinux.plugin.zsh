# Pacman

if (( $+commands[xdg-open] )); then
    function pacweb() {
        if [[ $# = 0 || "$1" =~ '--help|-h' ]]; then
            local underline_color="\e[${color[underline]}m"
            echo "$0 - open the website of an ArchLinux package"
            echo
            echo "Usage:"
            echo "    $bold_color$0$reset_color ${underline_color}target${reset_color}"
            return 1
        fi

        local pkg="$1"
        local infos="$(LANG=C pacman -Si "$pkg")"
        if [[ -z "$infos" ]]; then
            return
        fi
        local repo="$(grep -m 1 '^Repo' <<< "$infos" | grep -oP '[^ ]+$')"
        local arch="$(grep -m 1 '^Arch' <<< "$infos" | grep -oP '[^ ]+$')"
        xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
    }
fi
