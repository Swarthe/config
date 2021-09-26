# Universal variables
set -gx XDG_CACHE_HOME      "$HOME/.cache"
set -gx XDG_CONFIG_HOME     "$HOME/.config"
set -gx XDG_DATA_HOME       "$HOME/.local/share"

set -gx GNUPGHOME           "$XDG_CONFIG_HOME/gnupg"
set -gx GTK2_RC_FILES       "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -gx PARALLEL_HOME       "$XDG_CONFIG_HOME/parallel"
set -gx LESSHISTFILE        "$XDG_DATA_HOME/less/less.hist"

set -gx BACKUP_TARGET       "/mnt/desktop-backup/"
set -gx SCOT_TARGET         "$HOME/transient/"
set -gx SCOT_GRAPHICAL      "1"

set -gx BROWSER             "firefox"
set -gx DIFFPROG            "nvim -d"
set -gx EDITOR              "nvim"
set -gx PAGER               "less"

set -gx GTK_THEME           "Arc-Dark"

# Autostart X on TTY 1
if status -l && [ (tty) = /dev/tty1 ]
    startx
end

# Setup Vi mode and cursors
set -g fish_key_bindings "fish_vi_key_bindings"

# See this issue: <https://github.com/fish-shell/fish-shell/issues/4656>
set -g fish_cursor_default block blink
set -g fish_cursor_visual block blink
set -g fish_cursor_insert line blink
set -g fish_cursor_replace_one underscore blink
