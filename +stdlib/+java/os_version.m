function [os, version] = os_version()

os = javaMethod("getProperty", "java.lang.System", "os.name");
version = javaMethod("getProperty", "java.lang.System", "os.version");
os = string(os);
version = string(version);

end
