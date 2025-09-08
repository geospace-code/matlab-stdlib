function [os, version] = os_version()

try
  os = char(java.lang.System.getProperty('os.name'));
  version = char(java.lang.System.getProperty('os.version'));
catch e
  javaException(e)
  os = '';
  version = '';
end

end
