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
%%% Outputs
% issame: logical


function issame = samepath(path1, path2)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

% simpler our way than
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)

issame = stdlib.exists(path1) && stdlib.exists(path2) && ...
         stdlib.canonical(path1, false) == stdlib.canonical(path2, false);

end

%!assert(samepath(".", "."))
%!assert(samepath(".", "./"))
%!assert(!samepath("not-exist", "not-exist/.."))
