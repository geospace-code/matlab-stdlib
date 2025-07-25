function a = cpu_arch()

a = string(javaMethod("getProperty", "java.lang.System", "os.arch"));

end
