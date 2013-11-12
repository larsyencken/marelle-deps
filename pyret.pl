%
%  pyret.pl
%  deps
%
%  The Pyret programming language.
%

pkg('pyret').
met('pyret', _) :-
    isfile('~/.racket/links.rktd'),
    bash('fgrep -q pyret ~/.racket/links.rktd').
meet('pyret', _) :-
    bash('cd ~/.local/pyret && make dep && make').
depends('pyret', _, [
    '__pyret cloned',
    'racket'
]).

pkg('__pyret cloned').
met('__pyret cloned', _) :-
    isdir('~/.local/pyret').
meet('__pyret cloned', _) :-
    bash('mkdir -p ~/.local'),
    bash('cd ~/.local && git clone https://github.com/brownplt/pyret-lang pyret').
