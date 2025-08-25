%% GET_PROCESS_PRIORITY get priority of the current Matlab session
% This is an integer value like "nice" on Unix-like systems
% On Windows systems the char value is like 'Normal'

function [i, b] = get_process_priority(backend)
arguments
  backend (1,:) string = ["dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
i = o.func();

b = o.backend;

end
