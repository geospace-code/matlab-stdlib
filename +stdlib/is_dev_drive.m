%% IS_DEV_DRIVE is path on a Windows Dev Drive developer volume
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a Dev Drive
% * b: backend used

function [i, b] = is_dev_drive(file, backend)
arguments
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".is_dev_drive");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
