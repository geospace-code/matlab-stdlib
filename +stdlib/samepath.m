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
%%% Inputs
% * path1, path2: paths to compare

function y = samepath(path1, path2)
arguments
  path1 {mustBeTextScalar}
  path2 {mustBeTextScalar}
end


if stdlib.has_python()
  % For this function, Python is over 10x faster than Java
  y = stdlib.python.samepath(path1, path2);
elseif stdlib.has_java()
  y = stdlib.java.samepath(path1, path2);
elseif isunix()
  y = stdlib.sys.samepath(path1, path2);
else
  % string comparison is not preferred
  y = stdlib.native.samepath(path1, path2);
end

%!assert(samepath(".", "."))
%!assert(samepath(".", "./"))
%!assert(!samepath("not-exist", "not-exist/.."))
