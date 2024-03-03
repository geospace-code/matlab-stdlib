function issame = samepath(path1, path2)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

import java.io.File
import java.nio.file.Files
import stdlib.fileio.canonical

issame = false;
% java.nio.file.Files needs CANONICAL -- not just absolute path
p1 = canonical(path1);
if ~stdlib.fileio.exists(p1), return, end
p1 = File(p1).toPath();

p2 = canonical(path2);
if ~stdlib.fileio.exists(p2), return, end
p2 = File(p2).toPath();

issame = Files.isSameFile(p1, p2);

end
