%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

command_pkg(htop).
installs_with_apt(htop).
installs_with_brew(htop).

managed_pkg(mercurial).
managed_pkg(screen).

command_pkg(pstree).
installs_with_brew(pstree).
installs_with_apt(pstree, psmisc).

pkg(supervisor).
installs_with_apt(supervisor).
met(supervisor, osx) :- which(supervisorctl).
meet(supervisor, osx) :- bash('pip install supervisor').
depends(supervisor, osx, [pip]).
