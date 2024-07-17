function ok = is_writable(file)
%% is_writable is file writable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)

arguments
  file (1,1) string
end

import java.io.File
import java.nio.file.Files


ok = Files.isWritable(File(stdlib.absolute_path(file)).toPath());

end
