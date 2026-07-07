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
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

r = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".hostname");
  r = f();

  if ~ismissing(r)
    return
  end
end

end
