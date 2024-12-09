
%% HOSTNAME get hostname of local machine
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname()

if stdlib.isoctave()
  n = gethostname();
else
  n = string(java.net.InetAddress.getLocalHost().getHostName());
end

end
