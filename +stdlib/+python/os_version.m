function [os, version] = os_version()

try
  os = char(py.platform.system());
  version = char(py.platform.version());
catch e
  warning(e.identifier, 'Failed to get OS version using Python: %s', e.message)
  os = '';
  version = '';
end

end
