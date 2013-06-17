%
%  js.pl
%  deps
%
%  Javascript packages.
%

managed_pkg(node).

command_pkg(npm).
meet(npm, _).
depends(npm, _, [node]).

command_pkg(grunt).
meet(grunt, _) :-
    bash('sudo npm install grunt-cli -g').
depends(grunt, _, [npm]).
