%% HOSTNAME get hostname of local machine
%
%% Outputs
% * n: hostname of local machine
% * b: backend used
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function [n, b] = hostname(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
n = o.func();

b = o.backend;

end
