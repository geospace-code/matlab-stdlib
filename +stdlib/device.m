%% DEVICE filesystem device index of path
%
%%% Inputs
% * file: path to file
% * backend: backend to use
%%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
arguments
  file (1,1) string {mustBeFileOrFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".device");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
