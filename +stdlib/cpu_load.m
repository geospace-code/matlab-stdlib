%% CPU_LOAD get total physical CPU load
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * i: Returns the "recent cpu usage" for the whole system.
% * b: backend used
%
% This value is a double greater than 0.
% If the system recent cpu usage is not available, the backend returns a negative or NaN value.

function [i, b] = cpu_load(backend)
arguments
  backend (1,:) string = ["java", "python", "sys"]
end

i = [];

for b = backend
  switch b
    case 'java'
      i = stdlib.java.cpu_load();
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.cpu_load();
    case 'sys'
      i = stdlib.sys.cpu_load();
    otherwise
      error("stdlib:cpu_load:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
