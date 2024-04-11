function r = read_symlink(p)
%% read_symlink read symbolic link
arguments
  p (1,1) string
end

import java.io.File
import java.nio.file.Files

r = string.empty;

if ~stdlib.fileio.is_symlink(p) || ~stdlib.fileio.exists(p), return, end

r = stdlib.fileio.absolute_path(p);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
% must be absolute path
r = Files.readSymbolicLink(File(r).toPath());

end
