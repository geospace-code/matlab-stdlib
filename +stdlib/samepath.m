%% SAMEPATH is path the same
%
% true if inputs resolve to same path.
% Both paths must exist.
%
% NOTE: in general on Windows same('.', 'not-exist/..') is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
% Ref: https://devblogs.microsoft.com/oldnewthing/20220128-00/?p=106201
%
%%% inputs
% * path1, path2: paths to compare
% * backend: backend to use
%%% Outputs
% * i: true if paths are the same
% * b: backend used

function [i, b] = samepath(path1, path2, backend)
arguments
  path1 {mustBeTextScalar,mustBeFileOrFolder}
  path2 {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = ["python", "java", "shell", "native"]
end

[i, b] = getUsingBackend(backend, mfilename, path1, path2);

end
