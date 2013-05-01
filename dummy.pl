pkg(__fake1).

pkg(__fake2).
met(__fake2, _) :- fail.

pkg('__fake3-osx').
met('__fake3-osx', osx).

pkg('__fake4-ubuntu').
met('__fake4-ubuntu', linux(_)).
