function n = get_username()

n = char(javaMethod("getProperty", "java.lang.System", "user.name"));

end
