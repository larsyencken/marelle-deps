%
%  text.pl
%
%  Text processing utilities.
%

pip_pkg(nltk).

meta_pkg(malt, [
    '__malt binary',
    '__malt model'
]).

command_pkg('__malt binary', malt).
meet('__malt binary', _) :-
    ( isdir('~/.local/maltparser-1.7.1') ->
        true
    ;
        curl(
            'http://www.maltparser.org/dist/maltparser-1.7.1.tar.gz',
            '~/.local/maltparser-1.7.1.tar.gz'
        ),
        bash('cd ~/.local && tar xfz maltparser-1.7.1.tar.gz'),
        bash('rm -f ~/.local/maltparser-1.7.1.tar.gz')
    ),
    expand_path('~/.local/bin/malt', F),
    ( \+ isfile(F) ->
        tell(F),
        writeln('#!/bin/bash'),
        writeln('exec java -jar ~/.local/maltparser-1.7.1/maltparser-1.7.1.jar "$@"'),
        told
    ;
        true
    ),
    bash('chmod a+x ~/.local/bin/malt').

pkg('__malt model').
met('__malt model', _) :- isfile('~/.local/maltparser-1.7.1-models/engmalt.poly-1.7.mco').
meet('__malt model', _) :-
    bash('mkdir -p ~/.local/maltparser-1.7.1-models'),
    curl(
        'http://www.maltparser.org/mco/english_parser/engmalt.poly-1.7.mco',
        '~/.local/maltparser-1.7.1-models/engmalt.poly-1.7.mco'
    ).
