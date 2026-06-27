%% JAVA.HOME get the JAVA_HOME environment variable

function h = home()

try
  h = char(javaMethod('getProperty', 'java.lang.System', 'java.home'));
catch e
  h = javaException(e);
end

end
