%
%  vision.pl
%  marelle-deps
%
%  Support for computer vision.
%

% python's opencv module
python_pkg(cv2).
installs_with_apt(cv2, 'python-opencv').
depends(cv2, _, [opencv]).

pip_pkg(
    simplecv,
    'SimpleCV',
    'https://github.com/sightmachine/SimpleCV/zipball/develop'
).
depends(simplecv, _, [
    'cv2',
    pygame,
    ipython,
    numpy,
    scipy,
    pil
]).


% we could use Pillow via pip instead
python_pkg(pil, 'PIL').
installs_with_brew(pil).
installs_with_apt(pil, 'python-imaging').

python_pkg(pygame).
installs_with_apt(pygame, 'python-pygame').
installs_with_brew(pygame).
depends(pygame, osx, [
    smpeg,
    'homebrew-samueljohn-tap'
]).

pkg(smpeg).
met(smpeg, osx) :-
    isfile('/usr/local/lib/libsmpeg.dylib').
meet(smpeg, osx) :-
    bash('brew install --HEAD smpeg').
depends(smpeg, osx, [brew, 'homebrew-headonly-tap']).

brew_tap('homebrew-headonly-tap', 'homebrew/headonly').
brew_tap('homebrew-samueljohn-tap', 'samueljohn/python').

pkg(opencv).
installs_with_apt(opencv, 'libopencv-dev').
installs_with_brew(opencv).
depends(opencv, osx, ['homebrew-science-tap']).

pip_pkg(cython).
