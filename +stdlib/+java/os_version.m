function [os, version] = os_version()

try
  os = char(javaMethod('getProperty', 'java.lang.System', 'os.name'));
  version = char(javaMethod('getProperty', 'java.lang.System', 'os.version'));
catch e
  javaException(e)
  os = '';
  version = '';
end

end
