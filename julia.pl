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
:- dynamic julia_updated/0.
:- dynamic julia_updated2/0.

julia_pkg(P) :- nonvar(P), atom_concat(_, '.jl', P).

met(P, _) :-
    julia_pkg(P), !,
    atom_concat(Pkg, '.jl', P),
    bash(['! julia -e "using ', Pkg, '" 2>&1 | fgrep ERROR &>/dev/null']).

meet(P, _) :-
    julia_pkg(P), !,
    atom_concat(Pkg, '.jl', P),
    ( \+ julia_updated ->
        bash(['julia -e "Pkg.update()"']),
        assertz(julia_updated)
    ;
        true
    ),
    bash(['julia -e \'Pkg.add("', Pkg, '")\'']).

julia_pkg2(P) :- nonvar(P), atom_concat(_, '.jl2', P).

met(P, _) :-
    julia_pkg2(P), !,
    atom_concat(Pkg, '.jl2', P),
    bash(['! julia -e "using ', Pkg, '" 2>&1 | fgrep ERROR &>/dev/null']).

meet(P, _) :-
    julia_pkg2(P), !,
    atom_concat(Pkg, '.jl2', P),
    ( \+ julia_updated2 ->
        bash(['julia -e "Pkg2.update()"']),
        assertz(julia_updated2)
    ;
        true
    ),
    bash(['julia -e \'Pkg2.add("', Pkg, '")\'']).

pkg('PyCall.jl').
pkg('DataFrames.jl').
pkg('Calendar.jl').
pkg('Gadfly.jl').
pkg('Cairo.jl').
pkg('IJulia.jl2').
pkg('HttpServer.jl2').
pkg('Meddle.jl2').
pkg('HDF5.jl').
depends('HDF5.jl', _, [hdf5]).

pkg('Morsel.jl2').
depends('Morsel.jl2', _, ['HttpServer.jl2', 'Meddle.jl2']).

pkg('Winston.jl').
pkg('Distributions.jl').
pkg('ODBC.jl').


% enables dynamic packages, but makes pkg('PyCall.jl') succeed twice
pkg(P) :- nonvar(P), julia_pkg(P).

meta_pkg('julia-recommended', [
    'julia',
    'PyCall.jl',
    'DataFrames.jl',
    'Calendar.jl',
    'Gadfly.jl',
    'IJulia.jl2',
    'HttpServer.jl2',
    'Meddle.jl2',
    'Morsel.jl2'
]).
