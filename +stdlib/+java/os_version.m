function [os, version] = os_version()

os = char(java.lang.System.getProperty('os.name'));
version = char(java.lang.System.getProperty('os.version'));

end
