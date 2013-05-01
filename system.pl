%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

command_pkg(vim).
installs_with_brew(vim).
installs_with_apt(vim, 'vim-nox').

command_pkg(htop).
installs_with_brew(htop).
installs_with_apt(htop).
