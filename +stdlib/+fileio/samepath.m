function issame = samepath(path1, path2)
%% samepath(path1, path)
% true if inputs resolve to same path
% files need not exist
%%% Inputs
% * path1, path2: paths to compare
%%% Outputs
% issame: logical
arguments
  path1 string {mustBeScalarOrEmpty}
  path2 string {mustBeScalarOrEmpty}
end

import stdlib.fileio.absolute_path

issame = absolute_path(path1) == absolute_path(path2);

end
