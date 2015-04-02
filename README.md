## What's in it?
* vim
* fish shell
* ag
* j
* tmux
* various vim plugins 
* Awesome syntax highlighting with the [Solarized color scheme](http://ethanschoonover.com/solarized)
* Want to know more? [Fly Vim, First Class](http://corner.squareup.com/2013/08/fly-vim-first-class.html)

### vim

* `,d` brings up [NERDTree](https://github.com/scrooloose/nerdtree), a sidebar buffer for navigating and manipulating files
* `,t` brings up [ctrlp.vim](https://github.com/kien/ctrlp.vim), a project file filter for easily opening specific files
* `,b` restricts ctrlp.vim to open buffers
* `,a` starts project search with [ag.vim](https://github.com/rking/ag.vim) using [the silver searcher](https://github.com/ggreer/the_silver_searcher) (like ack, but faster)
* `ds`/`cs` delete/change surrounding characters (e.g. `"Hey!"` + `ds"` = `Hey!`, `"Hey!"` + `cs"'` = `'Hey!'`) with [vim-surround](https://github.com/tpope/vim-surround)
* `\\\` toggles current line comment
* `\\` toggles visual selection comment lines
* `vii`/`vai` visually select *in* or *around* the cursor's indent
* `Vp`/`vp` replaces visual selection with default register *without* yanking selected text (works with any visual selection)
* `,[space]` strips trailing whitespace
* `<C-]>` jump to definition using ctags
* `,l` begins aligning lines on a string, usually used as `,l=` to align assignments
* `<C-hjkl>` move between windows, shorthand for `<C-w> hjkl`

### tmux

* `<C-a>` is the prefix
* mouse scroll initiates tmux scroll
* `prefix v` makes a vertical split
* `prefix s` makes a horizontal split

If you have three or more panes:
* `prefix +` opens up the main-horizontal-layout
* `prefix =` opens up the main-vertical-layout

You can adjust the size of the smaller panes in `tmux.conf` by lowering or increasing the `other-pane-height` and `other-pane-width` options.

## Install

    rake

## Customize
In your home directory, Maximum Awesome creates `.vimrc.local`, `.vimrc.bundles.local` and `.tmux.conf.local` files where you can customize
Vim and tmux to your heart’s content. However, we’d love to incorporate your changes and improve Vim and tmux
for everyone, so feel free to fork Maximum Awesome and open some pull requests!

## Uninstall

    rake uninstall

Note that this won't remove everything, but your vim configuration should be reset to whatever it was before installing. Some uninstallation steps will be manual.
