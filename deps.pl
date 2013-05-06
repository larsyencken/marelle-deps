%
%  deps.pl
%  deps
%
%  Meta-deps.
%

:- dynamic hack_state/1.

pkg('update-deps').
met('update-deps', _) :- hack_state('update-deps').
meet('update-deps', _) :-
    bash('cd ~/.marelle/deps && git pull'),
    assertz(hack_state('update-deps')).
