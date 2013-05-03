%
%  util.pl
%  marelle-deps
%
%  Utility methods common to multiple deps.
%

:- multifile git_step/3.

pkg(P) :- git_step(P, _, _).
met(P, _) :-
    git_step(P, _, Dest0),
    join([Dest0, '/.git'], Dest),
    isdir(Dest).
meet(P, _) :-
    git_step(P, Repo, Dest0),
    expand_path(Dest0, Dest),
    git_clone(Repo, Dest).

expand_path(Path0, Path) :-
    ( atom_concat('~/', Suffix, Path0) ->
        getenv('HOME', Home),
        join([Home, '/', Suffix], Path)
    ;
        Path = Path0
    ).

isfile(Path0) :-
    expand_path(Path0, Path),
    exists_file(Path).

isdir(Path0) :-
    expand_path(Path0, Path),
    exists_directory(Path).

make_executable(Path) :-
    join(['chmod a+x ', Path], Cmd),
    shell(Cmd).

curl(Source, Dest) :-
    join(['curl -o ', Dest, ' ', Source], Cmd),
    shell(Cmd).


% installs_with_apt(Pkg).
%   Pkg installs with apt package of same name on all Ubuntu/Debian flavours
:- multifile installs_with_apt/1.

% installs_with_apt(Pkg, AptName).
%   Pkg installs with apt package called AptName on all Ubuntu/Debian flavours
:- multifile installs_with_apt/2.

installs_with_apt(P, P) :- installs_with_apt(P).

% installs_with_apt(Pkg, Codename, AptName).
%   Pkg installs with apt package called AptName on given Ubuntu/Debian
%   variant with given Codename.
:- multifile installs_with_apt/3.

installs_with_apt(P, _, AptName) :- installs_with_apt(P, AptName).

met(P, linux(Codename)) :-
    installs_with_apt(P, Codename, PkgName), !,
    check_dpkg(PkgName).

meet(P, linux(Codename)) :-
    installs_with_apt(P, Codename, PkgName), !,
    install_apt(PkgName).

check_dpkg(PkgName) :-
    join(['dpkg -s ', PkgName, ' >/dev/null 2>/dev/null'], Cmd),
    shell(Cmd).

% installs_with_brew(Pkg).
%  Pkg installs with homebrew package of same name.
:- multifile installs_with_brew/1.

% installs_with_brew(Pkg, BrewName).
%  Pkg installs with homebrew package called BrewName.
:- multifile installs_with_brew/2.

installs_with_brew(P, P) :- installs_with_brew(P).

met(P, osx) :-
    installs_with_brew(P, PkgName), !,
    join(['/usr/local/Cellar/', PkgName], Dir),
    isdir(Dir).

meet(P, osx) :-
    installs_with_brew(P, PkgName), !,
    install_brew(PkgName).

:- multifile meta_pkg/2.

pkg(P) :- meta_pkg(P, _).

met(P, _) :- meta_pkg(P, Deps), !,
    maplist(met, Deps).

meet(P, _) :- meta_pkg(P, _), !.

depends(P, _, Deps) :- meta_pkg(P, Deps).
