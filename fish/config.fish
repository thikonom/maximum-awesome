set fish_greeting ""

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


# --- Aliases ------------
alias size    'du -sh'

source /usr/local/share/autojump/autojump.fish

if test -f $HOME/.autojump/share/autojump/autojump.fish; . $HOME/.autojump/share/autojump/autojump.fish; end
