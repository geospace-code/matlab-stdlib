%% JAVA_HOME get the JAVA_HOME environment variable

function h = java_home()

try
  h = char(javaMethod('getProperty', 'java.lang.System', 'java.home'));
catch
  h = missing;
end

end
