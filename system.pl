%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

command_pkg(htop).
installs_with_brew(htop).
installs_with_apt(htop).

command_pkg(mercurial).
installs_with_brew(mercurial).
installs_with_apt(mercurial).

command_pkg(pstree).
installs_with_brew(pstree).
installs_with_apt(pstree, psmisc).
