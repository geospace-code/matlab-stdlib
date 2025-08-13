%% JAVA_HOME get the JAVA_HOME environment variable

function h = java_home()

try
  h = java.lang.System.getProperty('java.home');
catch
  h = '';
end

h = char(h);

end
