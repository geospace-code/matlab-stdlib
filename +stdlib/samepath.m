function issame = samepath(path1, path2)
%% samepath(path1, path)
% true if inputs resolve to same path
% files need not exist
%%% Inputs
% * path1, path2: paths to compare
%%% Outputs
% issame: logical
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

issame = false;
if ~stdlib.exists(path1) || ~stdlib.exists(path2)
  return
end

% needs absolute
path1 = stdlib.absolute(path1);
path2 = stdlib.absolute(path2);

issame = java.nio.file.Files.isSameFile(...
            java.io.File(path1).toPath(), ...
            java.io.File(path2).toPath());

% alternative, lower-level method is lexical only (not suitable for us):
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#equals(java.lang.Object)

end
