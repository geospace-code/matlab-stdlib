function r = read_symlink(p)
%% read_symlink read symbolic link
arguments
  p (1,1) string
end

import java.io.File
import java.nio.file.Files

r = stdlib.fileio.absolute_path(p);
if ~stdlib.fileio.exists(r) || ~stdlib.fileio.is_symlink(r)
  r = string.empty;
  return
end

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
% must be absolute path
r = Files.readSymbolicLink(File(r).toPath());

end