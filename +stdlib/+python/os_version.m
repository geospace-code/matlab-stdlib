function [os, version] = os_version()

try
  os = string(py.platform.system());
  version = string(py.platform.version());
catch e
  warning(e.identifier, 'Failed to get OS version using Python: %s', e.message)
  os = string.empty();
  version = string.empty();
end

end
