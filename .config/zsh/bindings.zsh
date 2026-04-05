# CTRL + Space to accept autosuggestion
bindkey '^I^I' autosuggest-accept

# Ctrl + N open nvim in current directory
bindkey -s "^N" "nvim .^M"
bindkey -s "^O" "nvim^M"

# Ctrl + G to open LazyGit
bindkey -s "^G" "lazygit^M"

# Ctrl + D to open LazyDocker
bindkey -s "^D" "lazydocker^M"

# Ctrl + B to open bottom
bindkey -s "^B" "btm^M"

# Ctrl + Y to open yazi
bindkey -s "^Y" "yazi^M"

# Ctrl + F to search shell history using atuin
bindkey '^f' atuin-search
