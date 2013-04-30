%
%  scheme.pl
%  marelle-deps
%

pkg(chicken).
detect(chicken, _) :- which(csi, _).
install(chicken, osx) :- install_brew(chicken).

pkg(racket).
detect(racket, _) :- which(racket, _).
install(racket, osx) :- install_brew('plt-racket').
install(racket, linux(_)) :- install_apt(racket).
