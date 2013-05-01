%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

command_pkg(vim).
meet(vim, osx) :- install_brew(vim).
meet(vim, linux(_)) :- install_apt(htop).

command_pkg(htop).
meet(vim, osx) :- install_brew(htop).
meet(vim, linux(_)) :- install_apt(htop).
