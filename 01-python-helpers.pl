%
%  01-python-helpers.pl
%  marelle-deps
%

% python_pkg(-Pkg) is nondet.
%   Pkg is a python module.
:- multifile python_pkg/1.

% pip_pkg(-Pkg) is nondet.
%   Pkg is a python module installable with pip.
:- multifile pip_pkg/1.

% pip_pkg(-Pkg, -Type) is nondet.
%   Pkg is a python module installable with pip. Type is either command
%   or module.
:- multifile pip_pkg/2.

%  All python packages are packages.
pkg(P) :- python_pkg(P).

%  If it's a Python package, it's met if you can import it.
met(P, _) :-
    python_pkg(P), !,
    python_import(P).

% python_import(+Pkg) is semidet.
%   Try to import the module in Python, failing if the import fails.
python_import(Pkg) :-
    join(['python -c \'import ', Pkg, '\' >/dev/null 2>/dev/null'], Cmd),
    shell(Cmd, 0).

%  All python packages depend on Python.
depends(P, _, [python]) :-
    python_pkg(P).

%  All pip packages are also packages.
pkg(P) :- pip_pkg(P).

%  all pip packages depend on pip
depends(P, _, [pip]) :- pip_pkg(P).

met(P, _) :-
    pip_pkg(P), !,
    join(['pip show ', P], Cmd),
    shellc(Cmd, Out),
    atom_length(Out, L),
    L > 0.

%  meet pip packages on any platform by installing them with pip
meet(P, _) :-
    pip_pkg(P), !,
    install_pip(P).

% install_pip(+Pkg) is semidet.
%   Try to install the pacakge with pip, maybe using sudo.
install_pip(Pkg) :-
    which(pip, Pip),
    atom_concat(Parent, '/pip', Pip),
    ( access_file(Parent, write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    join(['Installing ', Pkg, ' with pip'], Msg),
    writeln(Msg),
    join([Sudo, 'pip install -U ', Pkg], Cmd),
    shell(Cmd, 0).
