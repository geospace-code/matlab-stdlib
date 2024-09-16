function name = hostname()
  name = string(java.net.InetAddress.getLocalHost().getHostName());
end
