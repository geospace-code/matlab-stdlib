%% HOSTNAME get hostname of local machine
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * n: hostname of local machine
% * b: backend used
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function [r, b] = hostname(backend)
if nargin < 1
  backend = {'java', 'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

r = '';

for i = 1:numel(backend)
  b = backend{i};
  switch b
    case 'java'
      r = stdlib.java.hostname();
    case 'dotnet'
      r = stdlib.dotnet.hostname();
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.hostname();
      end
    case 'sys'
      r = stdlib.sys.hostname();
    otherwise
      error('stdlib:hostname:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end

%!assert (~isempty(stdlib.sys.hostname()))
