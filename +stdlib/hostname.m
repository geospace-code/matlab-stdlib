
%% HOSTNAME get hostname of local machine
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname()

n = '';

if stdlib.has_dotnet()
  n = stdlib.dotnet.get_hostname();
elseif stdlib.has_java()
  n = stdlib.java.get_hostname();
elseif stdlib.has_python()
  n = stdlib.python.get_hostname();
elseif stdlib.isoctave()
  n = gethostname();
end

end

%!assert (!isempty(hostname()))
