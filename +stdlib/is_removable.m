%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is on a removable drive
% * b: backend used

function [i, b] = is_removable(file, backend)
arguments
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".is_removable");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
