%% CPU_LOAD get total physical CPU load
%
%%% Outputs
% * a: Returns the "recent cpu usage" for the whole system.
% * b: backend used
%
% This value is a double greater than 0.
% If the system recent cpu usage is not available, the backend returns a negative or NaN value.

function [a, b] = cpu_load(backend)
arguments
  backend (1,:) string = ["java", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
a = o.func();

b = o.backend;

end
