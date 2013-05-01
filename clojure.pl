%
%  drake.pl
%  marelle-deps
%
%  A make replacement in Clojure.
%

pkg(clojure).
met(clojure, _) :- which(clj).
meet(clojure, osx) :- install_brew(clojure).
meet(clojure, linux(_)) :- install_apt(clojure).

pkg(leiningen).
met(leiningen, _) :- isfile('~/.local/bin/lein').
meet(leiningen, _) :-
    expand_path('~/.local/bin/lein', Path),
    curl('https://raw.github.com/technomancy/leiningen/stable/bin/lein', Path),
    make_executable(Path).

