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
  file (1,1) string {mustBeSymbolicLink}
  backend (1,:) string {mustBeNonempty} = ["native", "java", "python", "dotnet", "shell"]
end


for b = backend
  f = str2func("stdlib." + b  + ".read_symlink");
  r = f(file);

  if ~ismissing(r)
    return
  end
end

end
