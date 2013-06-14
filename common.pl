%
%  common.pl
%  marelle-deps
%

:- multifile managed_pkg/1.

pkg(P) :- managed_pkg(P).

installs_with_apt(P) :- managed_pkg(P).
installs_with_brew(P) :- managed_pkg(P).
