function [os, vers] = os_version()

if stdlib.has_python()
  os = char(py.platform.system());
  vers = char(py.platform.version());
else
  os = missing;
  vers = missing;
end

end
