%
%  julia.pl
%  marelle-deps
%
%  The Julia language for scientific computing.
%

pkg(julia).
met(julia, _) :-
    home_dir('.local/bin/julia', F),
    exists_file(F).
meet(julia, _).
depends(julia, _, [
    '__julia checked out',
    '__julia built',
    '__julia symlinked'
]).

pkg('__julia checked out').
met('__julia checked out', _) :-
    home_dir('.local/julia', D),
    exists_directory(D).
meet('__julia checked out', _) :-
    home_dir('.local/julia', D),
    git_clone('https://github.com/JuliaLang/julia', D).

pkg('__julia built').
met('__julia built', _) :-
    home_dir('.local/julia/julia', F),
    exists_file(F).
meet('__julia built', _) :-
    shell('cd ~/.local/julia && make -j4').
depends('__julia built', _, [
    gfortran,
    m4,
    ncurses
]).

pkg('__julia symlinked').
met('__julia symlinked', _) :-
    home_dir('.local/bin/julia', F),
    exists_file(F).
meet('__julia symlinked', _) :-
    shell('ln -s ~/.local/julia/julia ~/.local/bin/julia').

pkg(ncurses).
met(ncurses, osx) :- exists_file('/usr/lib/libncurses.dylib').
met(ncurses, linux(_)) :- exists_file('/usr/lib/libncurses.so').

pkg(gfortran).
met(gfortran, _) :- which(gfortran).

pkg(m4).
met(m4, _) :- which(m4).
