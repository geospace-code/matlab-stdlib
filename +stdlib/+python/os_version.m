function [os, vers] = os_version()

try
  os = char(py.platform.system());
  vers = char(py.platform.version());
catch e
  pythonException(e);
  os = missing;
  vers = missing;
end

end
