%
%  scheme.pl
%  marelle-deps
%

command_pkg(chicken).
installs_with_brew(chicken).
installs_with_apt(chicken, 'chicken-bin').

command_pkg(racket).
% Racket is broken on Homebrew currently: https://github.com/mxcl/homebrew/pull/17901
% installs_with_brew(racket, 'plt-racket').
installs_with_brew(racket, 'https://raw.github.com/kavu/homebrew/d23512a8fe2e7e77f0eef2e667d3846630112ab3/Library/Formula/plt-racket.rb').
installs_with_apt(racket).
