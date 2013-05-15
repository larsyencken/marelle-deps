%
%  ruby.pl
%  marelle-deps
%

command_pkg(ruby).

pkg(rvm).
met(rvm, _) :- isfile('~/.rvm/bin/rvm').
meet(rvm, _) :-
    bash('curl -L https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles').
