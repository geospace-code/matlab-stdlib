%% EXISTS does path exist
%
% NOTE: in general on Windows exists('./not-exist/..') is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
%%% Inputs
% * fpath: path to check
%%% Outputs
% * ok: true if exists
%
% this approach is at least 10x faster than checking empty on fileattrib() or dir()

function y = exists(fpath)

y = stdlib.is_file(fpath) || stdlib.is_folder(fpath);

end

%!assert (stdlib.exists('.'))
