function [os, version] = os_version()

try
  os = char(py.platform.system());
  version = char(py.platform.version());
catch e
  pythonException(e)
  os = '';
  version = '';
end

end
