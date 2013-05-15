pkg('__fake1').

pkg('__fake2').
met('__fake2', _) :- fail.

pkg('__fake3-osx').
met('__fake3-osx', osx).

pkg('__fake4-ubuntu').
met('__fake4-ubuntu', linux(_)).

pkg('__fake5-slow').
met('__fake5-slow', _) :- fail.
meet('__fake5-slow', _) :- bash('sleep 3600').

pkg('__fake6-sudo').
met('__fake6-sudo', _) :- isfile('~/sudo-works').
meet('__fake6-sudo', _) :-
    sudo_tell('~/sudo-works'),
    writeln('dog'),
    told,
    writeln('yay').
