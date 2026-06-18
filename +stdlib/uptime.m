%% UPTIME get system uptime in seconds
%
%%% Outputs
% * t: system uptime
% * b: backend used

function [r, b] = uptime(backend)
arguments
  backend (1,:) string = ["dotnet", "python", "shell"]
end

r = '';

for b = backend
  switch b
    case 'dotnet'
      r = stdlib.dotnet.uptime();
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.uptime();
      end
    case 'shell'
      r = stdlib.shell.uptime();
    otherwise
      error('stdlib:uptime:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end
