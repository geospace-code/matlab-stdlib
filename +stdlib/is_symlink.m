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
  file (1,1) string {mustBeFileOrFolder}
  backend (1,:) string {mustBeNonempty} = ["native", "java", "python", "dotnet", "shell"]
end


for b = backend
  f = str2func("stdlib." + b + ".is_symlink");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
