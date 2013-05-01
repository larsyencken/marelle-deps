%
%  scheme.pl
%  marelle-deps
%

command_pkg(chicken).
installs_with_brew(chicken).
installs_with_apt(chicken, 'chicken-bin').

command_pkg(racket).
installs_with_brew(racket, 'plt-racket').
installs_with_apt(racket).
