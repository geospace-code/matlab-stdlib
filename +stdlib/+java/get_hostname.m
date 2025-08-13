function n = get_hostname()

n = char(java.net.InetAddress.getLocalHost().getHostName());

end
