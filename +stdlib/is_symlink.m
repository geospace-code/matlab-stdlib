%% IS_SYMLINK is path a symbolic link
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a symbolic link
% * b: backend used

function [i, b] = is_symlink(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = ["native", "java", "python", "dotnet", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
