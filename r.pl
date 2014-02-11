%
%  r.pl
%  marelle-deps
%
%  The R statistical language.
%

:- multifile r_pkg/1.

r_cran_mirror('http://cran.ms.unimelb.edu.au/').

pkg(r).
met(r, _) :- which('R').
installs_with_apt(r, 'r-base').
installs_with_brew(r, 'R').
depends(r, osx, ['homebrew-science-tap']).

brew_tap('homebrew-science-tap', 'homebrew/science').

meta_pkg('r-recommended', [
  'caret.R',
  'reshape.R',
  'randomForest.R',
  'RColorBrewer.R',
  'boot.R',
  'tree.R',
  'e1071.R',
  %'medley.R',
  'xts.R',
  'maps.R',
  'geosphere.R'
]).

pkg('caret.R').
depends('caret.R', osx, [gettext]).

pkg('reshape.R').
pkg('randomForest.R').
pkg('RColorBrewer.R').
pkg('boot.R').
pkg('tree.R').
pkg('e1071.R').
pkg('medley.R').
pkg('xts.R').
pkg('maps.R').
pkg('geosphere.R').
pkg('ROAuth.R').
pkg('RCurl.R').

pkg('twitteR.R').
depends('twitteR.R', _, ['ROAuth.R', 'RCurl.R']).

pkg(P) :- nonvar(P), cran_pkg(P, _).
cran_pkg(P, PkgName) :-
    atom_concat(PkgName, '.R', P).

depends(P, _, [r]) :- cran_pkg(P, _).
met(P, _) :- cran_pkg(P, PkgName), imports_with_r(PkgName).
meet(P, _) :-
    cran_pkg(P, Pkg),
    r_cran_mirror(M),
    ( access_file('/usr/local/lib', write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    bash([Sudo, 'Rscript -e \'install.packages("', Pkg, '", repos="', M, '")\'']).

imports_with_r(P) :-
    bash(['Rscript -e \'library("', P, '")\' >/dev/null 2>/dev/null']).


:- multifile rgithub_pkg/2.

pkg(P) :- rgithub_pkg(P, _).
met(P, _) :- rgithub_pkg(P, _), imports_with_r(P).
depends(P, _, ['devtools.R']) :- rgithub_pkg(P, _).

meet(P, _) :-
    rgithub_pkg(P, User),
    bash([
        'Rscript -e \'',
        'library("RCurl"); library("devtools"); devtools::install_github("',
        P, '", "', User, '")\''
    ]).

rgithub_pkg(rga, skardhamar).
rgithub_pkg(assertthat, hadley).

rgithub_pkg(dplyr, hadley).
depends(dplyr, _, [assertthat]).

pkg(gettext).
met(gettext, osx) :-
    isfile('/usr/local/lib/libintl.dylib').
meet(gettext, osx) :-
    bash('brew install gettext'),
    bash('brew link gettext --force').
