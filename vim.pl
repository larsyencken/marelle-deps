%
%  vim.pl
%  marelle-deps
%

command_pkg(vim).
installs_with_apt(vim, 'vim-nox').
installs_with_brew(vim).

meta_pkg('dotvim', [
    '__dotvim checked out',
    '__dotvim symlinked',
    ctags,
    flake8
]).

git_step(
    '__dotvim checked out',
    'https://bitbucket.org/larsyencken/dotvim',
    '~/.vim'
).

symlink_step(
    '__dotvim symlinked',
    '~/.vim/vimrc',
    '~/.vimrc'
).

command_pkg(ctags).
installs_with_apt(ctags, 'exuberant-ctags').

pip_pkg(flake8).
