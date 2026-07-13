%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab
%
%%% inputs
% * file: path to symbolic link
% * backend: backend to use
%%% Outputs
% * i: target of symbolic link
% * b: backend used

function [i, b] = read_symlink(file, backend)
arguments
  file {mustBeTextScalar,mustBeSymbolicLink}
  backend (1,:) string = ["native", "java", "python", "dotnet", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
