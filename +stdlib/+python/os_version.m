function [os, vers] = os_version()

os = char(py.platform.system());
vers = char(py.platform.version());

end
