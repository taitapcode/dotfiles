set -gx EDITOR nvim
set -gx CPLUS_INCLUDE_PATH $HOME/.local/include $CPLUS_INCLUDE_PATH
set -gx LIBRARY_PATH $HOME/.local/lib $LIBRARY_PATH

fish_add_path $HOME/go/bin $HOME/.bun/bin $HOME/.cache/.bun/bin $HOME/.local/share/bin
