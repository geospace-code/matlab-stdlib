%% GET_PROCESS_PRIORITY get priority of the current Matlab session
% This is an integer value like 'nice' on Unix-like systems
% On Windows systems the char value is like 'Normal'
%
%%% Inputs
% * backend: backend(s) to use
%%% Outputs
% * i: integer priority value, empty if not available
% * b: backend used


function [i, b] = get_process_priority(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["dotnet", "python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".get_process_priority");
  i = f();

  if ~ismissing(i)
    return
  end
end

end
