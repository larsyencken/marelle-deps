%
%  julia.pl
%  marelle-deps
%
%  The Julia language for scientific computing.
%

%
%  julia
%
%  Install Julia as a binary package.
%
command_pkg(julia).

meet(julia, osx).  % met by dependencies
depends(julia, osx, ['julia-cask', 'julia-cask-symlink']).

cask_pkg('julia-cask', julia).

julia_cask_version(V) :-
    sh_output('brew cask info julia | head -n 1 | cut -d " " -f 2', V).

julia_cask_exec(Exec) :-
    julia_cask_version(V),
    join(['/opt/homebrew-cask/Caskroom/julia/', V, '/Julia-', V,
          '.app/Contents/Resources/julia/bin/julia'],
         Exec).

pkg('julia-cask-symlink').
met('julia-cask-symlink', osx) :-
    julia_cask_exec(Exec),
    is_symlinked(Exec, '/usr/local/bin/julia').
meet('julia-cask-symlink', osx) :-
    julia_cask_exec(Exec),
    symlink(Exec, '/usr/local/bin/julia').

%
%  julia_pkg
%
%  Install Julia packages using Julia's internal package management.
%
:- dynamic julia_updated/0.

pkg(P) :- julia_pkg(P).

met(P, _) :-
    julia_pkg(P), !,
    atom_concat(Pkg, '.jl', P),
    bash(['! julia -e "using ', Pkg, '" 2>&1 | fgrep ERROR &>/dev/null']).

meet(P, _) :-
    julia_pkg(P), !,
    atom_concat(Pkg, '.jl', P),
    ( \+ julia_updated ->
        bash(['julia -e "Pkg.update()"']),
        assertz(julia_updated)
    ;
        true
    ),
    bash(['julia -e \'Pkg.add("', Pkg, '")\'']).

depends(P, _, [julia]) :- julia_pkg(P).

%
%  julia packages
%
%  My personal collection of interesting packages.
%

meta_pkg('julia-recommended', [
    'Calendar.jl',
    'DataFrames.jl',
    'Gadfly.jl',
    'Graphs.jl',
    'HttpServer.jl',
    'IJulia.jl',
    'Meddle.jl',
    'Morsel.jl',
    'PyCall.jl'
]).

julia_pkg('Cairo.jl').
julia_pkg('Calendar.jl').
julia_pkg('DataArrays.jl').
julia_pkg('DataFrames.jl').
julia_pkg('Distributions.jl').
julia_pkg('GLM.jl').
julia_pkg('Gadfly.jl').
julia_pkg('Graphs.jl').
julia_pkg('HDF5.jl').
julia_pkg('Homebrew.jl').
julia_pkg('HttpServer.jl').
julia_pkg('IJulia.jl').
julia_pkg('Meddle.jl').
julia_pkg('Morsel.jl').
julia_pkg('PyCall.jl').
julia_pkg('RDatasets.jl').
julia_pkg('Winston.jl').
