%
%  scheme.pl
%  marelle-deps
%

command_pkg(chicken).
meet(chicken, osx) :- install_brew(chicken).
meet(chicken, linux(_)) :- install_apt('chicken-bin').

command_pkg(racket).
meet(racket, osx) :- install_brew('plt-racket').
meet(racket, linux(_)) :- install_apt(racket).
