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
arguments
  backend (1,:) string = ["java", "dotnet", "python", "shell"]
end

r = missing;

for b = backend
  switch b
    case 'java'
      r = stdlib.java.hostname();
    case 'dotnet'
      r = stdlib.dotnet.hostname();
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.hostname();
      end
    case 'shell'
      r = stdlib.shell.hostname();
    otherwise
      error('stdlib:hostname:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(r)
    return
  end
end

end

%!assert (~isempty(stdlib.shell.hostname()))
