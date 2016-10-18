set fish_greeting ""

function reload
    source ~/.config/fish/config.fish
end

function subl
    open -a "/Applications/Sublime Text 2.app" $argv
end


# --- Aliases ------------
alias size    'du -sh'

source /usr/local/share/autojump/autojump.fish

if test -f $HOME/.autojump/share/autojump/autojump.fish; . $HOME/.autojump/share/autojump/autojump.fish; end

eval (python -m virtualfish)
