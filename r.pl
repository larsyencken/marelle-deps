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


pkg(P) :- cran_pkg(P, _).
cran_pkg(P, PkgName) :- atom_concat(PkgName, '.R', P).
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


pkg(P) :- rgithub_pkg(P).
met(P, _) :- rgithub_pkg(P), imports_with_r(P).
depends(P, _, ['devtools.R']) :- rgithub_pkg(P).

meet(P, _) :-
    rgithub_pkg(P),
    bash([
        'Rscript -e \'',
        'library("RCurl"); library("devtools"); devtools::install_github("',
        P, '")\''
    ]).

rgithub_pkg(assertthat).
rgithub_pkg(dplyr).
depends(dplyr, _, [assertthat]).
