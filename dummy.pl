pkg(fake1).

pkg(fake2).
met(fake2, _) :- fail.

pkg('fake3-osx').
met('fake3-osx', osx).

pkg('fake4-ubuntu').
met('fake4-ubuntu', linux(_)).
