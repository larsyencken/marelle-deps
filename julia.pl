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

command_pkg(gfortran).
installs_with_apt(gfortran).
installs_with_brew(gfortran).

command_pkg(m4).
installs_with_apt(m4).
installs_with_brew(m4).
