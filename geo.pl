%
%  geo.pl
%  marelle-deps
%
%  Geo-location helper.
%

command_pkg(doko).
meet(doko, osx) :-
    % use corelocation for better results on osx
    install_pip('doko[corelocation]').
meet(doko, linux(_)) :-
    install_pip('doko').
