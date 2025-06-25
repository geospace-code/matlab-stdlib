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

% simpler our way than
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)

y = stdlib.exists(path1) && stdlib.exists(path2);

if ~y, return; end

if ~ispc() && stdlib.isoctave()
  [r1, e1] = stat(path1);
  [r2, e2] = stat(path2);

  y = e1 == 0 && e2 == 0 && ...
      r1.ino == r2.ino && r1.dev == r2.dev;

else
  y = strcmp(stdlib.canonical(path1), stdlib.canonical(path2));
end

%!assert(samepath(".", "."))
%!assert(samepath(".", "./"))
%!assert(!samepath("not-exist", "not-exist/.."))
