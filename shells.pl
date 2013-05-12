%
%  shells.pl
%  marelle-deps
%
%  UNIX shells.
%

pkg(bash).
met(bash, linux(_)) :- which(bash).
met(bash, osx) :- isfile('/usr/local/bin/bash').
meet(bash, osx) :- install_brew(bash).

pkg(zsh).
met(zsh, linux(_)) :- which(zsh).
met(zsh, osx) :- isfile('/usr/local/bin/zsh').
meet(zsh, osx) :- install_brew(zsh).
