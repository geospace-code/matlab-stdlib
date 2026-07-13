%% CPU_LOAD get total physical CPU load
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * i: Returns the 'recent cpu usage' for the whole system.
% * b: backend used
%
% This value is a double greater than 0.
% If the system recent cpu usage is not available, the backend returns a negative or NaN value.

function [i, b] = cpu_load(backend)
arguments
  backend (1,:) string = ["java", "python", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename);

end
