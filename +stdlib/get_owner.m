%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * file: path to examine
% * backend: backend to use
%%% Outputs
% * i: owner of file
% * b: backend used

function [i, b] = get_owner(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
