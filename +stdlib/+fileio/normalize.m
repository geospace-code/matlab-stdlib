function n = normalize(p)
% normalize(p) remove redundant elements of path p
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Path.html#normalize()
arguments
  p (1,1) string
end

import java.io.File
import stdlib.fileio.expanduser

n = stdlib.fileio.posix(File(expanduser(p)).toPath().normalize());

end
