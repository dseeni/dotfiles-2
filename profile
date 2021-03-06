# PROFILE #
# vim: ft=sh

# ENV VARIABLES

if [ -n "$BASH_VERSION" ]; then
    t=$BASH_SOURCE
elif [ -n "$ZSH_VERSION" ]; then
    t=${(%):-%x}
elif [ -n "$TMOUT" ]; then
    t=${.sh.file}
elif [ "${0##*/}" = "-dash" -o "${0##*/}" = "dash" ]; then
    t=$(lsof -p $$ -Fn0 | tail -1); t=${t#n}
else
    t=$0
fi

. "$(dirname $(realpath $t))/env_variables"; unset t

# AUTOSTART
for script in $XDG_CONFIG_HOME/autostart/*.sh; do
    . "$script"
done

# If available, use tmux, otherwise launch $SHELL // for TTY
[ -x "$(command -v tmux)" ] && exec tmux || exec $SHELL
