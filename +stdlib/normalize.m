function n = normalize(p)
%% normalize(p)
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Path.html#normalize()
arguments
  p (1,1) string
end

import java.io.File
import stdlib.expanduser

n = stdlib.posix(File(expanduser(p)).toPath().normalize());

if(strlength(n) == 0), n = "."; end

end
