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
  backend (1,:) string = ["dotnet", "python", "shell"]
end

i = [];

for b = backend
  switch b
    case 'dotnet'
      i = stdlib.dotnet.get_process_priority();
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.get_process_priority();
      end
    case 'shell'
      i = stdlib.shell.get_process_priority();
    otherwise
      error('stdlib:get_process_priority:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end
