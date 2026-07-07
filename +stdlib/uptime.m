%% UPTIME get system uptime in seconds
%
%%% Outputs
% * t: system uptime
% * b: backend used

function [r, b] = uptime(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["dotnet", "python", "shell"]
end

r = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".uptime");
  r = f();

  if ~ismissing(r)
    return
  end
end

end
