
%% HOSTNAME get hostname of local machine
%
% Ref: https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--

function n = hostname(method)
arguments
  method (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "get_hostname");

n = fun();

end
