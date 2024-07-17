function t = filesystem_type(p)
arguments
  p (1,1) string
end

import java.io.File
import java.nio.file.Files

t = string(Files.getFileStore(File(p).toPath()).type());

end
