function name = hostname()
  % Get the hostname of the local machine
  % https://docs.oracle.com/javase/8/docs/api/java/net/InetAddress.html#getHostName--
  name = string(java.net.InetAddress.getLocalHost().getHostName());
end
