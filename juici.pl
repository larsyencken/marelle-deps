%
%  juici.pl
%  marelle-deps
%

meta_pkg(juici, [
    ruby,
    gem,
    '__juici source checked out'
]).

command_pkg(ruby).

command_pkg(gem).
installs_with_apt(gem, rubygems).

git_step(
    '__juici source checked out',
    'https://github.com/richo/juici',
    '~/.local/juici'
).
