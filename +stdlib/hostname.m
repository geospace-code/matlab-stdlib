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
  backend = ["java", "dotnet", "python", "sys"];
else
  backend = string(backend);
end

r = '';

for b = backend
  switch b
    case "java"
      r = stdlib.java.hostname();
    case "dotnet"
      r = stdlib.dotnet.hostname();
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      r = stdlib.python.hostname();
    case "sys"
      r = stdlib.sys.hostname();
    otherwise
      error("stdlib:hostname:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(r)
    return
  end
end

end
