%
%  x11.pl
%  marelle-deps
%

pkg(x11).
met(x11, osx) :- isdir('/Applications/Utilities/XQuartz.app').
meet(x11, osx) :-
    writeln('Please download and install XQuartz manually'),
    writeln('http://xquartz.macosforge.org/'),
    !,
    fail.
