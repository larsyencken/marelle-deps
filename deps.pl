%
%  deps.pl
%  deps
%
%  Meta-deps.
%

:- dynamic deps_have_been_updated/0.

pkg('depupdate').
met('depupdate', _) :- deps_have_been_updated.
meet('depupdate', _) :-
    bash('cd ~/.marelle/deps && git pull'),
    assertz(deps_have_been_updated).
