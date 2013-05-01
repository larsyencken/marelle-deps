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
met(leiningen, _) :-
    home_dir('.local/bin/lein', F),
    exists_file(F).
meet(leiningen, _) :-
    home_dir('.local/bin/lein', Path),
    curl('https://raw.github.com/technomancy/leiningen/stable/bin/lein', Path),
    make_executable(Path).

make_executable(Path) :-
    join(['chmod a+x ', Path], Cmd),
    shell(Cmd).

curl(Source, Dest) :-
    join(['curl -o ', Dest, ' ', Source], Cmd),
    shell(Cmd).
