# PROFILE #
# vim: ft=sh fdm=marker fen

# --- XDG --- {{{1

if [ -n "$BASH" ]; then
    PROFILE_FILE=$BASH_SOURCE
elif [ -n "$ZSH_NAME" ]; then
    PROFILE_FILE=${(%):-%x}
elif [ -n "$TMOUT" ]; then
    PROFILE_FILE=${.sh.file}
elif [ "${0##*/}" = "-dash" -o "${0##*/}" = "dash" ]; then
    x=$(lsof -p $$ -Fn0 | tail -1); PROFILE_FILE=${x#n}
else
    PROFILE_FILE=$0
fi

export PROFILE_FILE
export XDG_DOTFILES_DIR="$(dirname $(realpath $PROFILE_FILE))"

. $XDG_DOTFILES_DIR/_XDG/env_variables

# Default browser/editor/terminal {{{1
export EDITOR=vim
export BROWSER=firefox
export TERMINAL=xterm

# man {{{1
export MANPAGER="vim -M +MANPAGER - +'set colorcolumn= nonumber laststatus=0'"
export MANWIDTH=80

# Theme {{{1

# GTK theme
export GTK_THEME="$(grep gtk-theme-name $GTK2_RC_FILES | cut -d'"' -f 2)"
export GTK2_RC_FILES="$GTK2_RC_FILES:$XDG_DATA_HOME/themes/$GTK_THEME/gtk-2.0/gtkrc"

# Set Qt to use GTK theme
export QT_QPA_PLATFORMTHEME=gtk2

# OTHER {{{1

# Japanese input
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx

# Enable GPG agent
export GPG_AGENT_INFO

# VITASDK
export VITASDK=/usr/local/vitasdk
export PATH=$VITASDK/bin:$PATH

# Autostart script {{{1
if [ ! -f /tmp/executed_autostart ]; then
    $XDG_DOTFILES_DIR/autostart.sh
    touch /tmp/executed_autostart
fi

### AUTO STARTX ### {{{1

# Enable automatic `startx`
export AUTO_STARTX

# If there is display and variable AUTO_STARTX is set then on tty1 `startx`
if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && [ "$(export -p | grep AUTO_STARTX)" ] && [ ! -f /tmp/disable_auto_startx ]; then

    # This is for optimus-manager
    sudo /usr/bin/prime-switch

    exec startx $XINITRC

elif [ -f /tmp/disable_auto_startx ]; then
    rm /tmp/disable_auto_startx
fi
