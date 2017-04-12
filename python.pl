%
%  python.pl
%  marelle-deps
%

%
%  a workbench of common tools in python
%
meta_pkg('python-recommended', [
    csvkit,
    h5py,
    ipython,
    jupyter,
    matplotlib,
    networkx,
    numpy,
    pandas,
    pip,
    scipy,
    'scikit-learn',
    sh,
    statsmodels,
    tables,
    virtualenv
]).

%
%  meta pacakges for working with python
%
managed_pkg(pyenv).

command_pkg(virtualenv).
installs_with_pip(virtualenv).


%
%  common python packages
%
pip_pkg(csvkit).
pip_pkg(h5py).
pip_pkg(jupyter).
pip_pkg(ipython).
pip_pkg(matplotlib).
pip_pkg(networkx).
pip_pkg(numexpr).
pip_pkg(numpy).
pip_pkg(pandas).
pip_pkg(pyaudio).
pip_pkg(scipy).
pip_pkg('scikit-learn').
pip_pkg(sh).
pip_pkg(statsmodels).
pip_pkg(tables).


%
%  extra deps for h5py
%
depends(h5py, _, [hdf5]).

pkg(hdf5).
installs_with_apt(hdf5, 'hdf5-tools').
installs_with_brew(hdf5).
depends(hdf5, linux(_), ['libhdf5-dev']).
depends(hdf5, osx, 'homebrew-science-tap').

managed_pkg('libhdf5-dev').


%
%  extra deps for pyaudio
%
depends(pyaudio, _, [portaudio]).

managed_pkg(portaudio).
