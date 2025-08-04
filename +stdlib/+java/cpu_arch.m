function a = cpu_arch()

a = char(javaMethod("getProperty", "java.lang.System", "os.arch"));

end
