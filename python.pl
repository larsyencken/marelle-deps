%
%  python.pl
%  marelle-deps
%

:- multifile command_pkg/1.

%  command_packages are met when their commands are in path
pkg(P) :- command_pkg(P).
met(P, _) :- which(P).

%  python is a command package
command_pkg(python).

%  All python packages are packages.
pkg(P) :- python_pkg(P).

%  If it's a Python package, it's met if you can import it.
met(P, _) :-
    python_pkg(P), !,
    python_import(P).

%  All python packages depend on Python.
depends(P, _, [python]) :-
    python_pkg(P).

% python_import(+Pkg) is semidet.
%   Try to import the module in Python, failing if the import fails.
python_import(Pkg) :-
    join(['python -c \'import ', Pkg, '\' 2>/dev/null'], Cmd),
    shell(Cmd, 0).


python_pkg(numpy).
python_pkg(scipy).
python_pkg('SimpleCV').
python_pkg(matplotlib).
python_pkg(networkx).

%  all pip packages are also Python packages
python_pkg(P) :- pip_pkg(P).

pip_pkg(pandas).
pip_pkg(virtualenv).
pip_pkg(clint).
pip_pkg(flask).

%  all pip packages depend on pip
depends(P, _, [pip]) :- pip_pkg(P).

%  meet pip packages on any platform by installing them with pip
meet(P, _) :- pip_pkg(P), !, install_pip(P).

command_pkg(anytop).
meet(anytop, _) :- install_pip(anytop).
depends(anytop, _, [pip]).

% install_pip(+Pkg) is semidet.
%   Try to install the pacakge with pip sans sudo.
install_pip(Pkg) :-
    join(['Installing ', Pkg, ' with pip'], Msg),
    writeln(Msg),
    join(['pip install ', Pkg], Cmd),
    shell(Cmd, 0).

command_pkg(ipython).
meet(ipython, osx) :- install_pip(ipython).
meet(ipython, linux(_)) :- install_apt(ipython).
