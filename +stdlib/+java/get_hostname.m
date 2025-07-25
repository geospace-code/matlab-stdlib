function n = get_hostname()

n = string(javaMethod("getLocalHost", "java.net.InetAddress").getHostName());

end
