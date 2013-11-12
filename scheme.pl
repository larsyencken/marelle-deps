%
%  scheme.pl
%  marelle-deps
%

command_pkg(chicken).
installs_with_brew(chicken).
installs_with_apt(chicken, 'chicken-bin').

pkg('racket').
met('racket', _) :-
    isfile('~/.local/racket-5.3.6/bin/raco').
meet('racket', _).
depends('racket', _, [
    '__racket installed',
    '__racket in profile'
]).

pkg('__racket in profile').
met('__racket in profile', _) :-
    bash('fgrep -q "racket-5.3.6" ~/.profile').
meet('__racket in profile', _) :-
    bash('echo \'export PATH=~/.local/racket-5.3.6/bin:${PATH}\' >> ~/.profile').

pkg('__racket installed').
met('__racket installed', _) :-
    isfile('~/.local/racket-5.3.6/bin/raco').
meet('__racket installed', linux(_)) :-
    bash('cd /tmp/racket-5.3.6/src && ./configure --prefix=$HOME/.local/racket-5.3.6 && make && make install').
meet('__racket installed', osx) :-
    bash('cd /tmp/racket-5.3.6/src && ./configure --prefix=$HOME/.local/racket-5.3.6 --enable-xonx && make && make install').
depends('__racket installed', _, [
    '__racket tarball unpacked'
]).

pkg('__racket tarball downloaded').
met('__racket tarball downloaded', _) :-
    isfile('/tmp/racket-5.3.6-src-unix.tgz').
meet('__racket tarball downloaded', _) :-
    bash('cd /tmp && wget http://download.racket-lang.org/installers/5.3.6/racket/racket-5.3.6-src-unix.tgz').
met('__racket tarball downloaded', _, [wget]).

pkg('__racket tarball unpacked').
met('__racket tarball unpacked', _) :-
    isdir('/tmp/racket-5.3.6').
meet('__racket tarball unpacked', _) :-
    bash('cd /tmp && tar xfz /tmp/racket-5.3.6-src-unix.tgz').
depends('__racket tarball unpacked', _, [
    '__racket tarball downloaded'
]).

command_pkg(wget).
