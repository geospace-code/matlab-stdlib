
%% HOSTNAME get hostname of local machine
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function name = hostname()
  name = string(java.net.InetAddress.getLocalHost().getHostName());
end
