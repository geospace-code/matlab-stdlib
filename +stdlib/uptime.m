%% UPTIME get system uptime in seconds
%
%%% Outputs
% * t: system uptime
% * b: backend used

function [r, b] = uptime(backend)
if nargin < 1
  backend = {'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

r = '';

for i = 1:numel(backend)
  b = backend{i};
  switch b
    case 'dotnet'
      r = stdlib.dotnet.uptime();
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.uptime();
      end
    case 'sys'
      r = stdlib.sys.uptime();
    otherwise
      error('stdlib:hostname:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end
