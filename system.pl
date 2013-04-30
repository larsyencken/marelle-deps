%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

pkg(vim).
met(vim, _) :- which(vim, _).
meet(vim, osx) :- meet_brew(vim).
meet(vim, linux(_)) :- meet_apt(htop).

pkg(htop).
met(htop, _) :- which(htop, _).
meet(vim, osx) :- meet_brew(htop).
meet(vim, linux(_)) :- meet_apt(htop).
