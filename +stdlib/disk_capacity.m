%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')
%
%%% inputs
% * file: path to check
%%% Outputs
% * f: total disk capacity (bytes)
% * b: backend used

function [i, b] = disk_capacity(file, backend)
arguments
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".disk_capacity");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
