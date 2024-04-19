function issame = samepath(path1, path2)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

import java.io.File
import java.nio.file.Files

issame = false;
if ~stdlib.fileio.exists(path1) || ~stdlib.fileio.exists(path2)
  return
end

% not correct without canoncial(). Normalize() doesn't help.
path1 = stdlib.fileio.canonical(path1);
path2 = stdlib.fileio.canonical(path2);

issame = Files.isSameFile(File(path1).toPath(), File(path2).toPath());

% alternative, lower-level method is lexical only (not suitable for us):
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#equals(java.lang.Object)

end
