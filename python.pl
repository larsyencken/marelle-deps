%
%  python.pl
%  marelle-deps
%

%  All python packages are packages.
pkg(P) :- python_pkg(P).

%  If it's a Python package, it's met if you can import it.
met(P, _) :-
    python_pkg(P), !,
    python_import(P).

% python_import(+Pkg) is semidet.
%   Try to import the module in Python, failing if the import fails.
python_import(Pkg) :-
    join(['python -c \'import ', Pkg, '\' 2>/dev/null'], Cmd),
    shell(Cmd, 0).

python_pkg(pandas).
python_pkg(numpy).
python_pkg(scipy).
python_pkg('SimpleCV').
python_pkg(virtualenv).
python_pkg(networkx).
python_pkg(clint).
python_pkg(flask).
python_pkg(matplotlib).

pkg(anytop).
met(anytop, _) :- which(anytop).

pkg(ipython).
met(ipython, _) :- which(ipython).
