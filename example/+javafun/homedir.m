function h = homedir()
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperty(java.lang.String)
% * https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/System.html#getProperties()

h = javaSystemProperty("user.home");
end
