set fish_greeting ""

# -------  Functions --------------
function wk
  $HOME/bin/wakeup.sh
end

function ip
  ipconfig getifaddr en0
end

function reload
    source ~/.config/fish/config.fish
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
alias clock 'tty-clock -c -s -C 3 -D'
# -----------------------

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

fish_default_key_bindings

[ -f (brew --prefix)/share/autojump/autojump.fish ]; and source (brew --prefix)/share/autojump/autojump.fish

status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

set fish_git_dirty_color red
set fish_git_not_dirty_color green
export PATH="$HOME/.local/bin:$PATH"

# OpenClaw Completion
source "/Users/mac/.openclaw/completions/openclaw.fish"

# pnpm
set -gx PNPM_HOME "/Users/mac/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
