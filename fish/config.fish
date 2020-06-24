set fish_greeting ""

# -------  Functions --------------
function reload
    source ~/.config/fish/config.fish
end

function subl
    open -a "/Applications/Sublime Text 2.app" $argv
end

function timer
    eval $HOME/bitbar_plugins/enabled/countdown_timer.1s.rb $argv
end

function bi
    brew update; and brew install $argv
end

function fim
    find . -name $argv | xargs -o vim
end

function sep
    set -lx wsearch $argv[1]
    set -lx wreplace $argv[2]
    ag -s -l $wsearch | xargs sed -i '' s/$wsearch/$wreplace/g
end

function fid
    lsof -n -i4TCP:$argv[1] | grep LISTEN
end
# --------------------------------

# ------- Aliases -------
alias size 'du -sh'
alias ll "ls -laGh"
# -----------------------

fish_vi_key_bindings

[ -f (brew --prefix)/share/autojump/autojump.fish ]; and source (brew --prefix)/share/autojump/autojump.fish


set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths

status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

set fish_git_dirty_color red
set fish_git_not_dirty_color green
