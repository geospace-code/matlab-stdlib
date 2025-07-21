
%% HOSTNAME get hostname of local machine
% optional: java
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname()

if NET.isNETSupported()
  n = string(System.Environment.MachineName);
elseif stdlib.isoctave()
  n = gethostname();
else
  n = string(java.net.InetAddress.getLocalHost().getHostName());
end

end

%!assert (!isempty(hostname()))
