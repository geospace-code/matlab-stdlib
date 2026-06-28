function [os, vers] = os_version()

if stdlib.has_java()
  os = char(javaMethod('getProperty', 'java.lang.System', 'os.name'));
  vers = char(javaMethod('getProperty', 'java.lang.System', 'os.version'));
else
  os = missing;
  vers = missing;
end

end
