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
    composer
    directories
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_PLUGINS_EXTERNAL/fast-syntax-highlighting
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
    starship
    sudo
    systemd
    tmux
    tmux-smart-sessions
    utils
    wezterm
    zoxide
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_PLUGINS_EXTERNAL/zsh-autosuggestions
    zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-completions.git $ZSH_PLUGINS_EXTERNAL/zsh-completions
    zsh-completions
    # git clone https://github.com/joshskidmore/zsh-fzf-history-search.git $ZSH_PLUGINS_EXTERNAL/zsh-fzf-history-search
    zsh-fzf-history-search
)

source $ZSH/init.zsh
source $ZSH/bindings.zsh
source $ZSH/bindings.zsh
source $HOME/.env.zsh

