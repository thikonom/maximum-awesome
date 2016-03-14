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
source $HOME/.config/fish/conda.fish

# activate default conda environment
condactivate job
