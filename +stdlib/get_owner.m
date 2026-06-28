%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * file: path to examine
% * backend: backend to use
%%% Outputs
% * r: owner of file
% * b: backend used

function [r, b] = get_owner(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".get_owner");
  r = f(file);

  if ~ismissing(r)
    return
  end
end

end
