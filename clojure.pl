%
%  drake.pl
%  marelle-deps
%
%  A make replacement in Clojure.
%

pkg(clojure).
installs_with_brew(clojure).
installs_with_apt(clojure).

pkg(leiningen).
met(leiningen, _) :- isfile('~/.local/bin/lein').
meet(leiningen, _) :-
    expand_path('~/.local/bin/lein', Path),
    curl('https://raw.github.com/technomancy/leiningen/stable/bin/lein', Path),
    make_executable(Path).
depends(leiningen, _, [java]).
