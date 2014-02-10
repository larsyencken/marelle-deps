%
%  mac.pl
%  marelle-deps
%

pkg(sequelpro) :- platform(osx).
met(sequelpro, osx) :- isdir('/Applications/Sequel Pro.app').
meet(sequelpro, osx) :-
    bash('cd ~/Downloads && test -f sequel-pro-1.0.2.dmg || wget https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg'),
    bash('hdiutil attach ~/Downloads/sequel-pro-1.0.2.dmg'),
    bash('cp -r "/Volumes/Sequel Pro 1.0.2/Sequel Pro.app" /Applications/'),
    bash('hdiutil detach "/Volumes/Sequel Pro 1.0.2"').
depends(sequelpro, osx, [wget]).

managed_pkg(wget).
