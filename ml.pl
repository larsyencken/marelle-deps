%
%  ml.pl
%  marelle-deps
%
%  Machine learning packages.
%

pip_pkg(orange, 'Orange').

pkg(mallet).
installs_with_brew(mallet).
depends(mallet, _, [java]).

command_pkg(weka).
installs_with_apt(weka).
depends(weka, _, [java]).
