%% HOSTNAME get hostname of local machine
%
%%% Inputs
% * backend: preferred backend(s)
%%% Outputs
% * i: hostname of local machine
% * b: backend used
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function [i, b] = hostname(backend)
arguments
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename);

end
