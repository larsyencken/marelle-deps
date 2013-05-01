%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

pkg(vim).
met(vim, _) :- which(vim).
meet(vim, osx) :- install_brew(vim).
meet(vim, linux(_)) :- install_apt(htop).

pkg(htop).
met(htop, _) :- which(htop).
meet(vim, osx) :- install_brew(htop).
meet(vim, linux(_)) :- install_apt(htop).
