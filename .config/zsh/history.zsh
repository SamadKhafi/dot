# history config
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000 # number of commands in memory
export SAVEHIST=10000 # number of commands to save in file

setopt HIST_IGNORE_ALL_DUPS # duplicates will be ignored
setopt HIST_FIND_NO_DUPS # duplicates won't be shown in search results
