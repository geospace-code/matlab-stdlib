function [os, vers] = os_version()

try
  os = char(javaMethod('getProperty', 'java.lang.System', 'os.name'));
  vers = char(javaMethod('getProperty', 'java.lang.System', 'os.version'));
catch e
  os = javaException(e);
  vers = missing;
end

end
