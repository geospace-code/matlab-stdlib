%% SAMEPATH is path the same
%
% true if inputs resolve to same path.
% Both paths must exist.
%
% NOTE: in general on Windows same(".", "not-exist/..") is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
%%% Inputs
% * path1, path2: paths to compare

function y = samepath(path1, path2)
arguments
  path1 {mustBeTextScalar}
  path2 {mustBeTextScalar}
end

if stdlib.has_python()
  y = stdlib.python.samepath(path1, path2);
else
  y = stdlib.sys.samepath(path1, path2);
end

%!assert(samepath(".", "."))
%!assert(samepath(".", "./"))
%!assert(!samepath("not-exist", "not-exist/.."))
