%
%  golang.pl
%  marelle-deps
%

meta_pkg(golang, [
    '__golang source fetched',
    '__golang built'
]).


pkg('__golang source fetched').
met('__golang source fetched', _) :-
    isdir('~/.local/go').
meet('__golang source fetched', _) :-
    bash('mkdir -p ~/.local'),
    bash('cd ~/.local && curl https://go.googlecode.com/files/go1.1.src.tar.gz | tar xz').

pkg('__golang built').
met('__golang built', _) :-
    isfile('~/.local/go/bin/go').
meet('__golang built', _) :-
    bash('cd ~/.local/go/src && ./all.bash').
