function n = hostname()

if stdlib.has_java()
  n = char(java.net.InetAddress.getLocalHost().getHostName());
else
  n = missing;
end

end
