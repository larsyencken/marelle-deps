%
%  emacs.pl
%  marelle-deps
%

pkg(emacs).
met(emacs, linux(_)) :-
    isfile('/usr/local/bin/emacs').
met(emacs, osx) :-
    isdir('/Applications/Emacs.app').

meet(emacs, linux(_)) :-
    installs_with_apt('emacs').
meet(emacs, osx) :-
    bash('brew install --cocoa --srgb emacs'),
    bash('brew linkapps').
