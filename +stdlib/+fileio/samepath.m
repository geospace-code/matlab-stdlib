function issame = samepath(path1, path2)
%% samepath(path1, path)
% true if inputs resolve to same path
arguments
  path1 (1,1) string {mustBeNonzeroLengthText}
  path2 (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.absolute_path

issame = absolute_path(path1) == absolute_path(path2);

end
