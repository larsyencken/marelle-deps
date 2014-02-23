%
%  emacs.pl
%  marelle-deps
%

pkg(emacs).
installs_with_apt('emacs').

met(emacs, osx) :-
    isdir('/Applications/Emacs.app').
meet(emacs, osx) :-
    bash('brew install --cocoa --srgb emacs'),
    bash('brew linkapps').
