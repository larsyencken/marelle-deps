%
%  scheme.pl
%  marelle-deps
%

pkg(chicken).
met(chicken, _) :- which(csi, _).
meet(chicken, osx) :- meet_brew(chicken).

pkg(racket).
met(racket, _) :- which(racket, _).
meet(racket, osx) :- meet_brew('plt-racket').
meet(racket, linux(_)) :- meet_apt(racket).
