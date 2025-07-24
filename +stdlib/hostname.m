
%% HOSTNAME get hostname of local machine
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname()

n = '';

if stdlib.has_dotnet()
  n = System.Environment.MachineName;
  % https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename
elseif stdlib.has_java()
  n = javaMethod("getLocalHost", "java.net.InetAddress").getHostName();
elseif stdlib.has_python()
  n = stdlib.python.get_hostname();
elseif stdlib.isoctave()
  n = gethostname();
end

try  %#ok<*TRYNC>
  n = string(n);
end

end

%!assert (!isempty(hostname()))
