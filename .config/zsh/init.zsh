# vim keybindings for zsh
bindkey -v

fpath+=$ZSH/func

autoload -Uz compinit
compinit

for plugin ($plugins); do
    # timer=$(date +%s%3N)

    if [ -f $ZSH_PLUGINS/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH_PLUGINS/$plugin/$plugin.plugin.zsh
    elif [ -f $ZSH_PLUGINS_EXTERNAL/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH_PLUGINS_EXTERNAL/$plugin/$plugin.plugin.zsh
    fi

    # now=$(date +%s%3N)
    # elapsed=$(($now-$timer))
    # echo $elapsed":" $plugin
done
