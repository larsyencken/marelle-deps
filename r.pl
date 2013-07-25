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
  caret,
  reshape,
  randomForest,
  'RColorBrewer',
  boot,
  tree,
  e1071,
  medley,
  xts
]).

cran_pkg(caret).
cran_pkg(reshape).
cran_pkg(randomForest).
cran_pkg('RColorBrewer').
cran_pkg(boot).
cran_pkg(tree).
cran_pkg(e1071).
cran_pkg(medley).
cran_pkg(devtools).
cran_pkg(xts).

r_pkg(P) :- cran_pkg(P) ; rgithub_pkg(P).

pkg(P) :- r_pkg(P).

met(P, _) :-
    r_pkg(P), !,
    bash(['Rscript -e \'library("', P, '")\' >/dev/null 2>/dev/null']).

meet(P, _) :-
    cran_pkg(P), !,
    r_cran_mirror(M),
    ( access_file('/usr/local/lib', write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    bash([Sudo, 'Rscript -e \'install.packages("', P, '", repos="', M, '")\'']).

depends(P, _, [r]) :- r_pkg(P).

rgithub_pkg(assertthat).
rgithub_pkg(dplyr).
depends(dplyr, _, [assertthat]).

depends(P, _, [devtools]) :- rgithub_pkg(P).

meet(P, _) :-
    rgithub_pkg(P), !,
    bash([
        'Rscript -e \'',
        'library("RCurl"); library("devtools"); devtools::install_github("',
        P, '")\''
    ]).
