%
%  drake.pl
%  marelle-deps
%
%  A make replacement in Clojure.
%

command_pkg(drake).
meet(drake, _).
depends(drake, _, ['java', '__drake executable set up']).

git_step('__drake checked out',
    'https://github.com/Factual/drake',
    '~/.local/drake'
).

pkg('__drake built').
met('__drake built', _) :-
    isfile('~/.local/drake/target/drake.jar').
meet('__drake built', _) :-
    bash('cd ~/.local/drake && ~/.local/bin/lein uberjar').
depends('__drake built', _, [
    'leiningen',
    '__drake checked out'
]).

pkg('__drake executable set up').
met('__drake executable set up', _) :- isfile('~/.local/bin/drake').
meet('__drake executable set up', _) :-
    expand_path('~/.local/bin/drake', F),
    tell(F),
    writeln('#!/bin/bash'),
    writeln('exec ~/.local/bin/drip -cp ~/.local/drake/target/drake.jar drake.core "$@"'),
    told,
    make_executable(F).
depends('__drake executable set up', _, [
    '__drake built',
    drip
]).

pkg(drip).
met(drip, _) :- isfile('~/.local/bin/drip').
meet(drip, _) :-
    curl(
        'https://raw.github.com/flatland/drip/master/bin/drip',
        '~/.local/bin/drip'
    ),
    bash('chmod a+x ~/.local/bin/drip').
