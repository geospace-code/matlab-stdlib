function n = hostname()

n = char(java.net.InetAddress.getLocalHost().getHostName());

end
