%
%  python.pl
%  marelle-deps
%

pkg(python).
installs_with_brew(python).
installs_with_apt(python, 'python-dev').

command_pkg(pip).
meet(pip, linux(_)) :-
    install_apt('python-pip').

depends(pip, _, [python]).

meta_pkg('python-recommended', [
    numpy,
    scipy,
    networkx,
    matplotlib,
    pandas,
    distribute,
    virtualenv,
    pip,
    ipython
]).

python_pkg(numpy).
python_pkg(scipy).
python_pkg('SimpleCV').

pip_pkg(pandas).
pip_pkg(virtualenv).
pip_pkg(clint).
pip_pkg(flask).
pip_pkg(distribute).
pip_pkg(anytop).
pip_pkg(networkx).

command_pkg(ipython).
installs_with_apt(ipython).
meet(ipython, osx) :- install_pip(ipython).
depends(ipython, osx, [pip]).

%  Vincent: a python to vega translator for charting
%  https://github.com/wrobstory/vincent/
python_pkg(vincent).
meet(vincent, _) :- install_pip('https://github.com/wrobstory/vincent/archive/master.zip').

python_pkg(matplotlib).
installs_with_apt(matplotlib, 'python-matplotlib').
