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
function fid
    lsof -n -i4TCP:$argv[1] | grep LISTEN
end



# --- Aliases ------------
alias size    'du -sh'

source /usr/local/share/autojump/autojump.fish
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)
pyenv activate myenv

set -g fish_user_paths "/usr/local/opt/elasticsearch@5.6/bin" $fish_user_paths

set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s)

  if test -n "$git_status"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  if test -n "$git_dir"
    printf '%s@%s %s%s%s:%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s@%s %s%s%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
