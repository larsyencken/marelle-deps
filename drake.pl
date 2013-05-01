%
%  drake.pl
%  marelle-deps
%
%  A make replacement in Clojure.
%

command_pkg(drake).
meet(drake, _).
depends(drake, _, ['__drake executable set up']).

pkg('__drake checked out').
met('__drake checked out', _) :-
    home_dir('.local/drake', D),
    exists_directory(D).
meet('__drake checked out', _) :-
    home_dir('.local/drake', D),
    git_clone('https://github.com/Factual/drake', D).

pkg('__drake built').
met('__drake built', _) :-
    home_dir('.local/drake/target/drake.jar', F),
    exists_file(F).
meet('__drake built', _) :-
    shell('cd ~/.local/drake && ~/.local/bin/lein uberjar').
depends('__drake built', _, [
    'leiningen',
    '__drake checked out'
]).

pkg('__drake executable set up').
met('__drake executable set up', _) :-
    home_dir('.local/bin/drake', F),
    exists_file(F).
meet('__drake executable set up', _) :-
    home_dir('.local/bin/drake', F),
    tell(F),
    writeln('#!/bin/bash'),
    writeln('exec java -jar ~/.local/drake/target/drake.jar "$@"'),
    told,
    make_executable(F).
depends('__drake executable set up', _, [
    '__drake built'
]).
