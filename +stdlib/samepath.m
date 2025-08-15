%% SAMEPATH is path the same
%
% true if inputs resolve to same path.
% Both paths must exist.
%
% NOTE: in general on Windows same(".", "not-exist/..") is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
% Ref: https://devblogs.microsoft.com/oldnewthing/20220128-00/?p=106201
%
%% Inputs
% * path1, path2: paths to compare
% * backend: backend to use, default is "python"
%% Outputs
% * ok: true if paths are the same
% * b: backend used

function [ok, b] = samepath(path1, path2, backend)
arguments
  path1 string
  path2 string
  backend (1,:) string = ["python", "java", "sys", "native"]
end

% For this function, Python is over 10x faster than Java

o = stdlib.Backend(mfilename(), backend);
b = o.backend;

if (isscalar(path1) && isscalar(path2)) || b == "native"
  ok = o.func(path1, path2);
else
  ok = arrayfun(o.func, path1, path2);
end


end
