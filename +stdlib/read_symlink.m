%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab
%
%%% inputs
% * file: path to symbolic link
% * backend: backend to use
%%% Outputs
% * r: target of symbolic link
% * b: backend used

function [r, b] = read_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  r = o.func(file);
else
  r = arrayfun(o.func, file);
end

b = o.backend;


end
