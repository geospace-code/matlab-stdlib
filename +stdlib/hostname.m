
%% HOSTNAME get hostname of local machine
% optional: java
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname()

n = '';

if stdlib.has_dotnet()
  n = System.Environment.MachineName;
  % https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename
elseif stdlib.isoctave()
  n = gethostname();
elseif stdlib.has_java()
  n = java.net.InetAddress.getLocalHost().getHostName();
end

try  %#ok<*TRYNC>
  n = string(n);
end

end

%!assert (!isempty(hostname()))
