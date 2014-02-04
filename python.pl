%
%  python.pl
%  marelle-deps
%

meta_pkg('python-recommended', [
    numpy,
    scipy,
    networkx,
    matplotlib,
    pandas,
    statsmodels,
    virtualenv,
    pip,
    ipython,
    csvkit,
    h5py,
    tables
]).

python_pkg(numpy).
installs_with_apt(numpy, 'python-numpy').
installs_with_pip(numpy) :- platform(osx).

python_pkg(scipy).
installs_with_apt(scipy, 'python-scipy').
installs_with_pip(scipy) :- platform(osx).
depends(scipy, osx, [gfortran, cython]).

command_pkg(virtualenv).
installs_with_pip(virtualenv).

pip_pkg(pandas).
pip_pkg(clint).
pip_pkg(flask).
pip_pkg(anytop).
pip_pkg(networkx).

command_pkg(csvkit, csvcut).
meet(csvkit, _) :-
    Pkg = csvkit,
    which(pip, Pip),
    atom_concat(Parent, '/pip', Pip),
    ( access_file(Parent, write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    join(['Installing ', Pkg, ' with pip'], Msg),
    writeln(Msg),
    bash(['umask a+rx && ', Sudo, 'pip install -U --allow-external argparse ', Pkg]).

pip_pkg(patsy).
pip_pkg('nodebox-opengl').
pip_pkg(numexpr).

pip_pkg(tables).
depends(tables, _, [numexpr]).

pip_pkg(statsmodels).
depends(statsmodels, _, [patsy]).

pip_pkg(h5py).
depends(h5py, _, [hdf5]).

pkg(hdf5).
installs_with_apt(hdf5, 'hdf5-tools').
installs_with_brew(hdf5).
depends(hdf5, linux(_), ['libhdf5-dev']).

managed_pkg('libhdf5-dev').

command_pkg(ipython).
installs_with_apt(ipython).
depends(ipython, osx, [pip]).

%  Vincent: a python to vega translator for charting
%  https://github.com/wrobstory/vincent/
python_pkg(vincent).
meet(vincent, _) :- install_pip('https://github.com/wrobstory/vincent/archive/master.zip').

python_pkg(matplotlib).
installs_with_apt(matplotlib, 'python-matplotlib').
installs_with_pip(matplotlib) :- platform(osx).
depends(matplotlib, osx, [freetype]).

managed_pkg(freetype).

command_pkg(pypy).
installs_with_brew(pypy).

pip_pkg(pyaudio).
depends(pyaudio, _, [portaudio]).

managed_pkg(portaudio).

command_pkg(fabric, fab).
installs_with_pip(fabric).

pip_pkg('scikits.audiolab').
depends('scikits.audiolab', _, [libsndfile]).

managed_pkg('libsndfile').

:- dynamic setuptoolsfix/0.
pkg('setuptools-fix').
met('setuptools-fix', _) :- setuptoolsfix.
meet('setuptools-fix', _) :-
    bash('curl -O http://python-distribute.org/distribute_setup.py'),
    ( access_file('/usr/local/lib', write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    bash([Sudo, 'python distribute_setup.py']),
    bash([Sudo, 'easy_install -U pip']),
    bash('rm -f distribute_setup.py && rm -f distribute-*.tar.gz'),
    assertz(setuptoolsfix).
