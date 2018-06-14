set fish_greeting ""

function reload
    source ~/.config/fish/config.fish
end

. $HOME/.autojump/share/autojump/autojump.fish

set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)
