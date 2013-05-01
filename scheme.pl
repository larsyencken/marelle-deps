%
%  scheme.pl
%  marelle-deps
%

pkg(chicken).
met(chicken, _) :- which(csi).
meet(chicken, osx) :- meet_brew(chicken).

pkg(racket).
met(racket, _) :- which(racket).
meet(racket, osx) :- install_brew('plt-racket').
meet(racket, linux(_)) :- install_apt(racket).
