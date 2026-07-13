%% INODE filesystem inode of path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: inode number - may be uint64 or string if larger than 64 bits
% * b: backend used

function [i, b] = inode(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
