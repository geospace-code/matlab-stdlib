%% UPTIME get system uptime in seconds
%
%%% Outputs
% * i: system uptime
% * b: backend used

function [i, b] = uptime(backend)
arguments
  backend (1,:) string = ["dotnet", "python", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename);

end
