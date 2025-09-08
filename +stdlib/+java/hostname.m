function n = hostname()

try
  n = char(java.net.InetAddress.getLocalHost().getHostName());
catch e
  javaException(e);
  n = '';
end

end
