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

import java.io.File
import java.nio.file.Files

issame = false;
if ~stdlib.exists(path1) || ~stdlib.exists(path2)
  return
end

% not correct without canonical(). Normalize() doesn't help.
path1 = stdlib.canonical(path1);
path2 = stdlib.canonical(path2);

issame = Files.isSameFile(File(path1).toPath(), File(path2).toPath());

% alternative, lower-level method is lexical only (not suitable for us):
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#equals(java.lang.Object)

end
