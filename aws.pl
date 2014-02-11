%
%  aws.pl
%  marelle-deps
%
%  Tools for working with AWS.
%

meta_pkg('aws-recommended', [
    s3cmd,
    boto,
    'elastic-mapreduce'
]).

managed_pkg(s3cmd).

pip_pkg(boto).

command_pkg('elastic-mapreduce').
meet('elastic-mapreduce', _).
depends('elastic-mapreduce', _, [
    '__emr shim'
]).

pkg('elastic-mapreduce-configured').
met('elastic-mapreduce-configured', _) :-
    isfile('~/.local/elastic-mapreduce/credentials.json').
meet('elastic-mapreduce-configured', _) :-
    bash('ln -s ~/.aws/current/credentials.json ~/.local/elastic-mapreduce/credentials.json').
depends('elastic-mapreduce-configured', _, [
    'elastic-mapreduce'
]).

pkg('__emr client').
met('__emr client', _) :- isdir('~/.local/elastic-mapreduce').
meet('__emr client', _) :-
    bash('mkdir -p ~/.local/bin && cd ~/.local && wget "http://elasticmapreduce.s3.amazonaws.com/elastic-mapreduce-ruby.zip" && unzip -d elastic-mapreduce elastic-mapreduce-ruby.zip && rm elastic-mapreduce-ruby.zip').
depends('__emr client', _, [ruby, unzip]).

pkg('__emr shim').
met('__emr shim', _) :- isfile('~/.local/bin/elastic-mapreduce').
meet('__emr shim', _) :-
    expand_path('~/.local/bin/elastic-mapreduce', F),
    tell(F),
    writeln('#!/bin/bash'),
    writeln('/usr/bin/ruby ~/.local/elastic-mapreduce/elastic-mapreduce "$@"'),
    told,
    make_executable(F).
depends('__emr shim', _, ['__emr client']).

command_pkg(unzip).
installs_with_apt(unzip).
