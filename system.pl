%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

pkg(vim).
detect(vim, _) :- which(vim, _).
install(vim, osx) :- install_brew(vim).
install(vim, linux(_)) :- install_apt(htop).

pkg(htop).
detect(htop, _) :- which(htop, _).
install(vim, osx) :- install_brew(htop).
install(vim, linux(_)) :- install_apt(htop).
