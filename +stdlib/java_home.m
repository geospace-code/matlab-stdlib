%% JAVA_HOME get the JAVA_HOME environment variable

function h = java_home()

try
  h = javaMethod("getProperty", "java.lang.System", "java.home");
catch
  h = '';
end

end

%!assert(!isempty(java_home()))
