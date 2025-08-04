function n = get_hostname()

n = char(javaMethod("getLocalHost", "java.net.InetAddress").getHostName());

end
