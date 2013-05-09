%
%  git.pl
%  deps
%
%  Git helpers.
%

pkg(gitx).
met(gitx, osx) :- (
        isdir('/Applications/GitX.app')
    ;
        isdir('~/Applications/GitX.app')
    ).

meet(gitx, osx) :-
    bash('cd ~/Downloads && wget http://frim.frim.nl/GitXStable.app.zip'),
    bash('cd ~/Downloads && unzip GitXStable.app.zip'),
    bash('mv ~/Downloads/GitX.app /Applications/GitX.app').

command_pkg(tig).
installs_with_brew(tig).
installs_with_apt(tig).
