%
%  julia.pl
%  marelle-deps
%
%  The Julia language for scientific computing.
%

pkg(julia).
met(julia, _) :- isfile('~/.local/bin/julia').
meet(julia, _).
depends(julia, _, [
    '__julia checked out',
    '__julia built',
    '__julia symlinked'
]).

git_step('__julia checked out',
    'https://github.com/JuliaLang/julia',
    '~/.local/julia'
).

pkg('__julia built').
met('__julia built', _) :- isfile('~/.local/julia/julia').
meet('__julia built', _) :-
    bash('cd ~/.local/julia && make -j4').
depends('__julia built', _, [
    gfortran,
    m4,
    ncurses
]).

pkg('__julia symlinked').
met('__julia symlinked', _) :- isfile('~/.local/bin/julia').
meet('__julia symlinked', _) :-
    bash('ln -s ~/.local/julia/julia ~/.local/bin/julia').

pkg(ncurses).
met(ncurses, osx) :-
    isfile('/usr/lib/libncurses.dylib').
installs_with_apt(ncurses, precise, libncurses5).
installs_with_apt(ncurses, raring, libncurses5).

managed_pkg(gfortran).
managed_pkg(m4).

% define julia packages
:- multifile julia_pkg/1.
:- dynamic julia_updated/0.

pkg(P) :- julia_pkg(P).

met(P, _) :-
    julia_pkg(P), !,
    bash(['! julia -e "using ', P, '" 2>&1 | fgrep ERROR &>/dev/null']).

meet(P, _) :-
    julia_pkg(P), !,
    ( \+ julia_updated ->
        bash(['julia -e "Pkg.update()"']),
        assertz(julia_updated)
    ;
        true
    ),
    bash(['julia -e \'Pkg.add("', P, '")\'']).

meta_pkg('julia-recommended', [
    'julia',
    'PyCall',
    'DataFrames'
]).

julia_pkg('PyCall').
julia_pkg('DataFrames').
