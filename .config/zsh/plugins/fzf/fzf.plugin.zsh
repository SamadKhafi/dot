# tokyonight_night colorscheme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# source file if it exists
include() {
    [[ -f "$1" ]] && source "$1"
}

# fzf completion & keybindings
include /usr/share/fzf/completion.zsh
include /usr/share/fzf/key-bindings.zsh
include /usr/share/doc/fzf/examples/completion.zsh
include /usr/share/doc/fzf/examples/key-bindings.zsh
