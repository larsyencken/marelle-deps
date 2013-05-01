%
%  python.pl
%  marelle-deps
%

python_import(Pkg) :-
    join(['python -c \'import ', Pkg, '\' 2>/dev/null'], Cmd),
    shell(Cmd, 0).

pkg(pandas).
met(pandas, _) :- python_import(pandas).

pkg(numpy).
met(numpy, _) :- python_import(numpy).

pkg(scipy).
met(scipy, _) :- python_import(scipy).

pkg('SimpleCV').
met('SimpleCV', _) :- python_import('SimpleCV').

pkg(virtualenv).
met(virtualenv, _) :- python_import(virtualenv).

pkg(networkx).
met(networkx, _) :- python_import(networkx).

pkg(anytop).
met(anytop, _) :- which(anytop).
