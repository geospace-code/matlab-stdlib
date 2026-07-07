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
  path1 (1,1) string {mustBeFileOrFolder}
  path2 (1,1) string {mustBeFileOrFolder}
  backend (1,:) string {mustBeNonempty} = ["python", "java", "perl", "shell", "native"]
end


i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".samepath");
  i = f(path1, path2);

  if ~ismissing(i)
    return
  end
end

end
