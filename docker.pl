%
%  docker.pl
%  marelle-deps
%
%  LXC virtualisation.
%

command_pkg(docker).
installs_with_apt(docker, 'lxc-docker').
depends(docker, linux(_), '__docker ppa').
depends(docker, osx, [boot2docker]).

meet(docker, osx) :-
    curl('https://get.docker.io/builds/Darwin/x86_64/docker-latest', '~/.local/bin/docker'),
    bash('chmod a+x ~/.local/bin/docker').

git_step('docker-source',
    'https://github.com/dotcloud/docker',
    '~/.local/docker'
).

pkg('__docker ppa').
met('__docker ppa', linux(_)) :-
    isfile('/etc/apt/sources.list.d/docker.list').
meet('__docker ppa', linux(CodeName)) :-
    member(CodeName, [precise, quantal]),
    bash('sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E61D797F63561DC6'),
    join(['deb http://ppa.launchpad.net/dotcloud/lxc-docker/ubuntu ', CodeName, ' main'], AptLine),
    sudo_tell('/etc/apt/sources.list.d/docker.list'),
    writeln(AptLine),
    told,
    bash('sudo apt-get update').


command_pkg(boot2docker).
meet(boot2docker, osx) :-
    curl('https://raw.github.com/steeve/boot2docker/master/boot2docker', '~/.local/bin/boot2docker'),
    bash('chmod a+x ~/.local/bin/boot2docker').
