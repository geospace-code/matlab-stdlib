function n = hostname()

try
  n = char(java.net.InetAddress.getLocalHost().getHostName());
catch e
  n = javaException(e);
end

end
