export ZSH="$HOME/.config/zsh"
export ZSH_PLUGINS="$ZSH/plugins"
export ZSH_PLUGINS_EXTERNAL="$ZSH/external"

source $ZSH/history.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# plugins
plugins=(
    appearance
    archlinux
    bob
    bun
    cargo
    colored-man-pages
    command-not-found
    directories
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_PLUGINS/fast-syntax-highlighting
    fast-syntax-highlighting
    fnm
    fzf
    git
    go
    history-substring-search
    myconf
    nvim
    open
    pnpm
    rbw
    starship
    sudo
    systemd
    tmux
    tmux-smart-sessions
    utils
    wezterm
    zoxide
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_PLUGINS/zsh-autosuggestions
    zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-completions.git $ZSH_PLUGINS/zsh-completions
    zsh-completions
    # git clone https://github.com/joshskidmore/zsh-fzf-history-search.git $ZSH_PLUGINS/zsh-fzf-history-search
    zsh-fzf-history-search
)

source $ZSH/init.zsh
source $ZSH/bindings.zsh
source $ZSH/bindings.zsh
source $ZSH/env.zsh

# bun completions
[ -s "/home/samad/.bun/_bun" ] && source "/home/samad/.bun/_bun"
