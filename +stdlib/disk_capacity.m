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
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

i = uint64.empty;

for b = backend
  switch b
    case 'dotnet'
      i = stdlib.dotnet.disk_capacity(file);
    case 'java'
      i = stdlib.java.disk_capacity(file);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.disk_capacity(file);
    case 'sys'
      i = stdlib.sys.disk_capacity(file);
    otherwise
      error("stdlib:disk_capacity:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
