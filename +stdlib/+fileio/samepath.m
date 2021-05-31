function issame = samepath(path1, path2)
%% issame = samepath(path1, path)
% true if inputs resolve to same path

import stdlib.fileio.absolute_path

issame = absolute_path(path1) == absolute_path(path2);

end
