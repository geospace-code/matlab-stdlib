function ok = is_readable(file)
%% is_readable is file readable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)

arguments
  file (1,1) string
end

import java.io.File
import java.nio.file.Files


ok = Files.isReadable(File(stdlib.absolute_path(file)).toPath());

end
