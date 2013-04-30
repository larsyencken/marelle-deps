pkg(fake1).

pkg(fake2).
detect(fake2, _) :- fail.

pkg('fake3-osx').
detect('fake3-osx', osx).

pkg('fake4-ubuntu').
detect('fake4-ubuntu', linux(_)).
