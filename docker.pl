%
%  docker.pl
%  marelle-deps
%
%  LXC virtualisation.
%

command_pkg(docker).
installs_with_apt(docker, 'lxc-docker').
depends(docker, linux(_), '__docker ppa').

git_step('docker-source',
    'https://github.com/dotcloud/docker',
    '~/.local/docker'
).

pkg('__docker ppa').
met('__docker ppa', linux(_)) :-
    isfile('/etc/apt/sources.list.d/docker.list').
meet('__docker ppa', linux(CodeName)) :-
    member(CodeName, [precise, quantal]),
    bash(['sudo sh -c "echo \'deb http://ppa.launchpad.net/dotcloud/lxc-docker/ubuntu ', CodeName, ' main\' >> /etc/apt/sources.list.d/docker.list"']),
    bash('sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E61D797F63561DC6'),
    bash('sudo apt-get update').
