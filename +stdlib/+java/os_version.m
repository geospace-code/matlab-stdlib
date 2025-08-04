function [os, version] = os_version()

os = char(javaMethod("getProperty", "java.lang.System", "os.name"));
version = char(javaMethod("getProperty", "java.lang.System", "os.version"));

end
