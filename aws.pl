%
%  aws.pl
%  marelle-deps
%
%  Tools for working with AWS.
%

meta_pkg('aws-recommended', [
    s3cmd,
    boto
]).

managed_pkg(s3cmd).

pip_pkg(boto).
