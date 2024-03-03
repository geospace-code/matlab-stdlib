function isabs = is_absolute_path(apath)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#isAbsolute()
arguments
  apath (1,1) string
end

import java.io.File

% expanduser() here to work like C++ filesystem::path::is_absolute()
isabs = File(stdlib.fileio.expanduser(apath)).isAbsolute();

end
