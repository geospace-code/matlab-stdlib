function ok = is_symlink(p)
%% is_symlink is path symbolic link
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)

arguments
  p (1,1) string
end

import java.io.File
import java.nio.file.Files

% must be absolute path
f = File(stdlib.fileio.absolute_path(p)).toPath();
ok = Files.isSymbolicLink(f);

end
